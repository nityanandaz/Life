#import "GridVisitors.h"
#import "Grid.h"
#import "Cell.h"

@implementation TickVisitor

+visitor { return [[self new] autorelease]; }

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
  visitor->replacementDenizen = [aDenizen retain];
  return [visitor autorelease];
}

-visitDenizen:denizen
       onGrid:grid
  ofDimension:(NSInteger)n
	  atX:(NSInteger)x
	    y:(NSInteger)y
{
  return replacementDenizen;
}

- (void)dealloc
{
  [replacementDenizen release];
  [super dealloc];
}

@end

@implementation Visitation

+visitationOnGrid:aGrid ofDimension:(NSInteger)n byVisitor:aVisitor
{
  Visitation *aVisitation = [[self new] autorelease];
  aVisitation->allVisited = [NSMutableArray new];
  aVisitation->grid = [aGrid retain];
  aVisitation->visitor = [aVisitor retain];
  aVisitation->cursor = 0;
  aVisitation->dimension = n;
  return aVisitation;
}

-(void)dealloc
{
  [allVisited release];
  [grid release];
  [visitor release];
  [super dealloc];
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
  return [[[Grid alloc] initWithSideLength:dimension
				  dwellers:allVisited] autorelease];
}

@end
