#import "NSNumber+Times.h"

@interface NSNumber (timesimplementation)
-realTimes:target perform:(SEL)action withObject:object;
-nonZero;
@end

@implementation NSNumber (times)

-times:target perform:(SEL)action
{
    return [self times:target perform:action withObject:nil];
}

-times:target perform:(SEL)action withObject:object
{
    return [[self nonZero] realTimes:target
                             perform:action
                          withObject:object];
}

@end

@implementation NSNumber (timesimplementation)

-realTimes:target perform:(SEL)action withObject:object
{
    [target performSelector:action withObject:object];
    return [[NSNumber numberWithInteger:[self integerValue] - 1]
            times:target perform:action withObject:object];
}

-nonZero
{
    return ([self integerValue] != 0)?self:nil;
}

@end

