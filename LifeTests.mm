#define CATCH_CONFIG_MAIN
#include "catch.hpp"
#import "Grid.h"
#import "GridVisitors.h"
#import "Cell.h"
#import "TestDefinitions.h"

TEST_CASE("I have a repeating n*n grid", "[grid]") {
  Grid *grid = [Grid withSideLength:2];
  REQUIRE(grid != nil);
  grid = [grid atX:0 y:0 put:[NSNull null]];
  REQUIRE([[grid atX:0 y:0] isEqual:[NSNull null]]);
  REQUIRE([grid atX:1 y:0] == nil);
  REQUIRE([[grid atX:2 y:0] isEqual:[NSNull null]]);
}

TEST_CASE("Cells can be alive or dead", "[cell]") {
  REQUIRE([[Cell living] population] == 1);
  REQUIRE([[Cell dead] population] == 0);
}

TEST_CASE("A cell can be added to a grid", "[cell->grid]") {
  Cell *cell = [Cell living];
  Grid *grid = [[Grid withSideLength:1] atX:0 y:0 put:cell];
  REQUIRE([[grid atX:0 y:0] isEqual:cell]);
}

TEST_CASE("A cell can tell how many neighbours are alive",
          "[cell->neighbours]") {
  Grid *grid = [[Grid withSideLength:3]
		 populateWithCellLifeFunction:alternately_fill_grid];
  REQUIRE([[grid atX:0 y:0] neighboursOnGrid:grid atX:0 y:0] == 4);
  REQUIRE([[grid atX:1 y:0] neighboursOnGrid:grid atX:1 y:0] == 3);
}

TEST_CASE("A grid can tick", "[grid->tick]") {
  GridCitizen *dweller = [GridCitizen new];
  Grid *grid = [[[Grid withSideLength:1] atX:0 y:0 put:dweller] tick];
  GridCitizen *nextDweller = [grid atX:0 y:0];
  REQUIRE([dweller didTick] == NO);
  REQUIRE([nextDweller didTick] == YES);
}

TEST_CASE("Live cells die following Conway's rules", "[cell->tick]") {
  Grid *grid = [[Grid withSideLength:3]
		 populateWithCellLifeFunction:zero_living_neighbours];
  Cell *middleCell = [grid atX:1 y:1];
  REQUIRE([[middleCell tickOnGrid:grid atX:1 y:1] population] == 0);
}

TEST_CASE("Live cells stay alive following Conway's rules", "[cell->tick]") {
  Grid *grid = [[Grid withSideLength:3]
		 populateWithCellLifeFunction:horizontal_bar];
  Cell *middleCell = [grid atX:1 y:1];
  REQUIRE([[middleCell tickOnGrid:grid atX:1 y:1] population] == 1);
}

TEST_CASE("Dead cells stay dead following Conway's rules", "[cell->tick]") {
  Grid *grid = [[Grid withSideLength:3]
		 populateWithCellLifeFunction:all_cells_dead];
  Cell *middleCell = [grid atX:1 y:1];
  REQUIRE([[middleCell tickOnGrid:grid atX:1 y:1] population] == 0);
}

TEST_CASE("Dead cells resurrect following Conway's rules", "[cell->tick]") {
  Grid *grid = [[Grid withSideLength:3]
		 populateWithCellLifeFunction:horizontal_bar];
  Cell *topCentre = [grid atX:1 y:0];
  REQUIRE([[topCentre tickOnGrid:grid atX:1 y:0] population] == 1);
}

TEST_CASE("Dead and living cells swap on population change", "[cell->change]") {
  REQUIRE([[[Cell living] changePopulation] population] == 0);
  REQUIRE([[[Cell dead] changePopulation] population] == 1);
}

TEST_CASE("Grids can be totally repopulated", "[grid->population]") {
  REQUIRE([[[[Grid withSideLength:2] fillWith:[NSNull null]]
	     atX:1 y:1] isEqual:[NSNull null]]);
}

TEST_CASE("Grid population can be visited", "[grid->visit]") {
  CountVisitor *counter = [CountVisitor new];
  [[Grid withSideLength:2] visit:counter];
  REQUIRE([counter count]==4);
}

TEST_CASE("A single grid denizen can be messageed", "[grid->perform]") {
  Grid *grid = [[Grid withSideLength:1] fillWith:[Cell living]];
  grid = [grid atX:0 y:0 perform:@selector(changePopulation)];
  REQUIRE([[grid atX:0 y:0] isEqual:[Cell dead]]);
}
