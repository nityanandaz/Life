#import <Foundation/Foundation.h>

@interface Grid : NSObject <NSCopying>

@property NSArray *array;
@property NSInteger n;

-initWithSideLength:(NSInteger)length;
-initWithSideLength:(NSInteger)length dwellers:anArray;

@end
