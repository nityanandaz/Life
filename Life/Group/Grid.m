#import "Grid.h"
#import "Life-Swift.h"

@implementation Grid

@synthesize n;
@synthesize array;

-initWithSideLength:(NSInteger)length
{
    return [[super init] _configureWithSideLength:length];
}

-initWithSideLength:(NSInteger)length dwellers:anArray
{
    return [[super init] _configureWithSideLength:length dwellers:anArray];
}

@end
