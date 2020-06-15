#import "Grid.h"
#import "GridVisitors.h"

#ifdef __cplusplus
extern "C" {
#endif
BOOL alternately_fill_grid(int i, int j);
BOOL zero_living_neighbours(int i, int j);
BOOL all_cells_dead(int i, int j);
BOOL horizontal_bar(int i, int j);

typedef BOOL(*CellIsAlive)(int,int);

@interface Grid (BitmapPopulation)

-populateWithCellLifeFunction:(CellIsAlive)f;

@end

@interface GridCitizen : NSObject
{
  BOOL didTick;
}

-tickOnGrid:grid atX:(NSInteger)x y:(NSInteger)y;
-(BOOL)didTick;

@end

@interface CountVisitor : NSObject <GridVisitor>
{ NSInteger count; }
-increment;
-(NSInteger)count;
@end

@interface GridPopulator : NSObject <GridVisitor>
{ CellIsAlive bitmap; }
+populatorWithBitmap:(CellIsAlive)function;
@end

#ifdef __cplusplus
}
#endif
