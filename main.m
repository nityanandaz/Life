#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <Renaissance/Renaissance.h>

#import "LifeAppDelegate.h"

int main(int argc, const char **argv)
{
  CREATE_AUTORELEASE_POOL(pool);
  [[NSApplication sharedApplication] setDelegate:[LifeAppDelegate new]];
  [NSBundle loadGSMarkupNamed:@"Menu" owner:[NSApp delegate]];

  RELEASE(pool);
  return NSApplicationMain(argc,argv);
}
