#import "TestDefinitions.h"
#import "Cell.h"

@implementation CountVisitor
-increment { count++; return self; }
-(NSInteger)count { return count; }
-visitDenizen:denizen
       onGrid:grid
  ofDimension:(NSInteger)n
	  atX:(NSInteger)x
	    y:(NSInteger)y
{
  return [self increment];
}
@end

BOOL alternately_fill_grid(int i, int j) { return ((i*3 + j) % 2); }
BOOL zero_living_neighbours(int i, int j) { return ((i==1) && (j==1)); }
BOOL all_cells_dead(int i, int j) { return NO; }
BOOL horizontal_bar(int i, int j) { return (j==1); }

@implementation GridPopulator

+populatorWithBitmap:(CellIsAlive)function
{
  GridPopulator *populator = [self new];
  populator->bitmap = function;
  return populator;
}

-visitDenizen:denizen
       onGrid:grid
  ofDimension:(NSInteger)n
	  atX:(NSInteger)x
	    y:(NSInteger)y
{
  return (bitmap(x,y) ? [Cell living] : [Cell dead]);
}

@end

@implementation Grid(BitmapPopulation)

-populateWithCellLifeFunction:(CellIsAlive)f
{
  return [self visit:[GridPopulator populatorWithBitmap:f]];
}

@end

@implementation GridCitizen

-tickOnGrid:grid atX:(NSInteger)x y:(NSInteger)y
{
  GridCitizen *next = [GridCitizen new];
  next->didTick = YES;
  return [next autorelease];
}

-(BOOL)didTick
{
  return didTick;
}

@end
