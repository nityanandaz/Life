#import <Foundation/Foundation.h>

@interface Cell : NSObject

+living;
+dead;
-changePopulation;
-(NSInteger)population;
-(NSInteger)neighboursOnGrid:grid atX:(NSInteger)x y:(NSInteger)y;
-tickOnGrid:grid atX:(NSInteger)x y:(NSInteger)y;

@end
