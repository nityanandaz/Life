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

-atX:(NSInteger)x y:(NSInteger)y put:object
{
    id localArray = [array mutableCopy];
    [localArray replaceObjectAtIndex:[self _indexForX:x y:y]
                          withObject:object];
    return [[[self class] alloc] initWithSideLength:n dwellers:localArray];
}

-atX:(NSInteger)x y:(NSInteger)y
{
    id result = [array objectAtIndex:[self _indexForX:x y:y]];
    return [result isKindOfClass:[EmptyCell class]]?nil:result;
}

-atX:(NSInteger)x y:(NSInteger)y perform:(SEL)aSelector
{
    return [self atX:x y:y put:[[self atX:x y:y] performSelector:aSelector]];
}

-fillWith:denizen
{
    return [self visit:[[PopulateVisitor alloc] initWithReplacementDenizen:denizen]];
}

@end
