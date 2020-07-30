#import <Foundation/Foundation.h>

@interface Grid : NSObject <NSCopying>

@property NSArray *array;
@property NSInteger n;

-initWithSideLength:(NSInteger)length;
-initWithSideLength:(NSInteger)length dwellers:anArray;
-atX:(NSInteger)x y:(NSInteger)y put:object;
-atX:(NSInteger)x y:(NSInteger)y;
-atX:(NSInteger)x y:(NSInteger)y perform:(SEL)aSelector;
-fillWith:denizen;

@end
