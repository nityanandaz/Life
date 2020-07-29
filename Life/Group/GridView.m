#import "GridView.h"
#import "Cell.h"
#import "Grid.h"
#import "GridVisitors.h"
#import "Life-Swift.h"

@interface DrawingVisitor:NSObject <GridVisitor>
{ id view; }
+ visitorForView:aView;
@end

@implementation DrawingVisitor

+ visitorForView:aView
{
    DrawingVisitor *visitor = [self new];
    visitor->view = aView;
    return visitor;
}

-visitDenizen:denizen
       onGrid:grid
  ofDimension:(NSInteger)n
          atX:(NSInteger)x
            y:(NSInteger)y
{
    float beginningHorizontal = (float)x/(float)n;
    float beginningVertical = (float)y/(float)n;
    float horizontalExtent = 1.0/(float)n;
    float verticalExtent = 1.0/(float)n;
    NSSize boundsSize = [view bounds].size;
    NSRect cellRectangle =
    NSMakeRect(
               beginningHorizontal * boundsSize.width,
               beginningVertical * boundsSize.height,
               horizontalExtent * boundsSize.width,
               verticalExtent * boundsSize.height
               );
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:cellRectangle];
    [[NSColor colorWithCalibratedWhite:[denizen population] alpha:1.0] set];
    [path stroke];
    [[NSColor colorWithCalibratedWhite:(1.0 - [denizen population]) alpha:1.0] set];
    [path fill];
    return denizen;
}

@end

@implementation GridView

@synthesize lifeController;

// initWithCoder gets called

-drawGrid:aGrid
{
    currentGrid = aGrid;
    [self setNeedsDisplay:YES];
    return self;
}

-(void)drawRect:(NSRect)dirtyRect
{
    [currentGrid visit:[DrawingVisitor visitorForView:self]];
}

// just to get it working ignore mouse tracking
-(void)mouseUp:theEvent
{
    NSPoint location = [self convertPoint:[theEvent locationInWindow]
                                 fromView:nil];
    NSSize boundsSize = [self bounds].size;
    float fractionX = location.x/boundsSize.width;
    float fractionY = location.y/boundsSize.height;
    [self.lifeController changeCellAtRelativeX:fractionX y:fractionY];
}

@end
