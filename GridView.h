#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface GridView : NSView
{
  id currentGrid;
  id lifeController;
}

@property (nonatomic, assign) id lifeController;

-drawGrid:aGrid;

@end
