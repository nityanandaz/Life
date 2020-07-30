#import "Grid.h"
#import "Life-Swift.h"

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

-neighboursOfX:(NSInteger)x y:(NSInteger)y
{
    return [[[self _verticalNeighboursOfX:x y:y]
             arrayByAddingObjectsFromArray:
             [self _horizontalNeighboursOfX:x y:y]]
            arrayByAddingObjectsFromArray:
            [self _diagonalNeighboursOfX:x y:y]];
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
