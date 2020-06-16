#import "GridVisitors.h"
#import "Grid.h"
#import "Cell.h"

@implementation TickVisitor

+visitor { return [self new]; }

-visitDenizen:denizen
       onGrid:grid
  ofDimension:(NSInteger)n
          atX:(NSInteger)x
            y:(NSInteger)y
{
    return [denizen tickOnGrid:grid atX:x y:y];
}

@end

@implementation PopulateVisitor

+ populateWith:aDenizen
{
    PopulateVisitor *visitor = [self new];
    visitor->replacementDenizen = aDenizen;
    return visitor;
}

-visitDenizen:denizen
       onGrid:grid
  ofDimension:(NSInteger)n
          atX:(NSInteger)x
            y:(NSInteger)y
{
    return replacementDenizen;
}

@end

@implementation Visitation

+visitationOnGrid:aGrid ofDimension:(NSInteger)n byVisitor:aVisitor
{
    Visitation *aVisitation = [self new];
    aVisitation->allVisited = [NSMutableArray new];
    aVisitation->grid = aGrid ;
    aVisitation->visitor = aVisitor;
    aVisitation->cursor = 0;
    aVisitation->dimension = n;
    return aVisitation;
}

-visitNext
{
    NSInteger x = cursor / dimension;
    NSInteger y = cursor % dimension;
    cursor++;
    id visited = [visitor visitDenizen:[grid atX:x y:y]
                                onGrid:grid
                           ofDimension:dimension
                                   atX:x
                                     y:y];
    [allVisited addObject:visited];
    return visited;
}

-visitedGrid
{
    return [[Grid alloc] initWithSideLength:dimension
                                   dwellers:allVisited];
}

@end
