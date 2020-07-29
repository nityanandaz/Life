#import <Foundation/Foundation.h>

@interface LifeController : NSObject
{
    id grid;
}

@property (retain, readonly, nonatomic) id grid;
@property (assign, nonatomic) id gridView;

-changeCellAtRelativeX:(float)fractionX y:(float)fractionY;
-(IBAction)tick:sender;

@end
