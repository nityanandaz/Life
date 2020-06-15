#import <Foundation/Foundation.h>

@interface Grid : NSObject <NSCopying>
{
    NSArray *array;
    NSInteger n;
}

+withSideLength:(NSInteger)length;
-initWithSideLength:(NSInteger)length dwellers:anArray;
-atX:(NSInteger)x y:(NSInteger)y put:object;
-atX:(NSInteger)x y:(NSInteger)y;
-atX:(NSInteger)x y:(NSInteger)y perform:(SEL)aSelector;
-neighboursOfX:(NSInteger)x y:(NSInteger)y;
-tick;
-fillWith:denizen;
-visit:visitor;

@end
