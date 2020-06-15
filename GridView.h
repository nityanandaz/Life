#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface GridView : NSView
{
    id currentGrid;
}

@property (nonatomic, assign) id lifeController;

-drawGrid:aGrid;

@end
