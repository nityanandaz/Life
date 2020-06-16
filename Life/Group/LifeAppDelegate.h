#import <AppKit/AppKit.h>

@interface LifeAppDelegate : NSObject <NSApplicationDelegate>
{
    id lifeController, timer;
}

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification;

@end
