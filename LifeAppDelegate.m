#import "LifeAppDelegate.h"

#import <AppKit/AppKit.h>
//#import <Renaissance/Renaissance.h>

@implementation LifeAppDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //  [NSBundle loadGSMarkupNamed:@"Window" owner:self];
}

-(IBAction)tick:sender
{
    [lifeController tick:sender];
}

-(IBAction)runTimer:sender
{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:lifeController
                                           selector:@selector(tick:)
                                           userInfo:nil
                                            repeats:YES];
}

-(IBAction)stopTimer:sender
{
    [timer invalidate];
    timer = nil;
}

-(BOOL)validateMenuItem:menuItem
{
    id action = NSStringFromSelector([menuItem action]);
    SEL validateSelector = NSSelectorFromString([@"validate"
                                                 stringByAppendingString:action]);
    return [[self performSelector:validateSelector withObject:menuItem]
            boolValue];
}

-validaterunTimer:menuItem
{
    return @(timer == nil);
}

-validatestopTimer:menuItem
{
    return @(timer != nil);
}

-validatetick:menuItem
{
    return @(timer == nil);
}

-validatequit:menuItem
{
    return @(YES);
}
@end
