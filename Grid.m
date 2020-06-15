#import "Grid.h"
#import "GridVisitors.h"
#import "NSNumber+Times.h"

@interface EmptyCell : NSObject
@end

@implementation EmptyCell
-tickOnGrid:grid atX:(NSInteger)x y:(NSInteger)y { return self; }
@end

@interface Grid (guts)
-(NSInteger)indexForX:(NSInteger)x y:(NSInteger)y;
-configureWithSideLength:(NSInteger)length;
-configureWithSideLength:(NSInteger)length dwellers:anArray;
@end

@implementation Grid (guts)

-(NSInteger)indexForX:(NSInteger)x y:(NSInteger)y
{
  NSInteger index = ((x+n)%n)*n + ((y+n)%n);
  NSAssert((index >= 0) && (index < n*n), @"Should be in range");
  return index;
}

-configureWithSideLength:(NSInteger)length
{
  NSAssert(length > 0, @"Grids must have positive length");
  EmptyCell *empty = [EmptyCell new];
  id dwellers = [[NSMutableArray alloc] initWithCapacity:length*length];
  [[NSNumber numberWithInteger:length*length]
	     times:dwellers perform:@selector(addObject:) withObject:empty];
  return [self configureWithSideLength:length dwellers:dwellers];
}

-configureWithSideLength:(NSInteger)length dwellers:anArray
{
  NSAssert(length > 0, @"Grids must have positive length");
  NSAssert([anArray count] == length*length, @"Grids must be populated");
  n = length;
  array = [anArray copy];
  return self;
}

@end

@implementation Grid

-initWithSideLength:(NSInteger)length
{
  return [[super init] configureWithSideLength:length];
}

-initWithSideLength:(NSInteger)length dwellers:anArray
{
  return [[super init] configureWithSideLength:length dwellers:anArray];
}

+withSideLength:(NSInteger)length
{
  return [[self alloc] initWithSideLength:length];
}

-atX:(NSInteger)x y:(NSInteger)y put:object
{
  id localArray = [array mutableCopy];
  [localArray replaceObjectAtIndex:[self indexForX:x y:y]
			withObject:object];
  return [[[self class] alloc] initWithSideLength:n dwellers:localArray];
}

-atX:(NSInteger)x y:(NSInteger)y
{
  id result = [array objectAtIndex:[self indexForX:x y:y]];
  return [result isKindOfClass:[EmptyCell class]]?nil:result;
}

-atX:(NSInteger)x y:(NSInteger)y perform:(SEL)aSelector
{
  return [self atX:x y:y put:[[self atX:x y:y] performSelector:aSelector]];
}

-verticalNeighboursOfX:(NSInteger)x y:(NSInteger)y
{
  return [NSArray arrayWithObjects:
			 [self atX:x y:y-1],
			 [self atX:x y:y+1],
		  nil];
}

-horizontalNeighboursOfX:(NSInteger)x y:(NSInteger)y
{
  return [NSArray arrayWithObjects:
			 [self atX:x-1 y:y],
			 [self atX:x+1 y:y],
		  nil];
}

-diagonalNeighboursOfX:(NSInteger)x y:(NSInteger)y
{
  return [NSArray arrayWithObjects:
			 [self atX:x-1 y:y-1],
			 [self atX:x-1 y:y+1],
			 [self atX:x+1 y:y-1],
			 [self atX:x+1 y:y+1],
		  nil];
}

-neighboursOfX:(NSInteger)x y:(NSInteger)y
{
  return [[[self verticalNeighboursOfX:x y:y]
		    arrayByAddingObjectsFromArray:
		    [self horizontalNeighboursOfX:x y:y]]
		    arrayByAddingObjectsFromArray:
		      [self diagonalNeighboursOfX:x y:y]];
}

-tick
{
  return [self visit:[TickVisitor visitor]];
}

-fillWith:denizen
{
  return [self visit:[PopulateVisitor populateWith:denizen]];
}

-visit:visitor
{
  id visitation = [Visitation visitationOnGrid:self
				   ofDimension:n
				     byVisitor:visitor];
  [[NSNumber numberWithInteger:n*n] times:visitation
				  perform:@selector(visitNext)];
  return [visitation visitedGrid];
}

-copyWithZone:(NSZone *)zone
{
  return [[Grid allocWithZone:zone] initWithSideLength:n dwellers:array];
}

@end
