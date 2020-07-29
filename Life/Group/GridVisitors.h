#import <Foundation/Foundation.h>

@interface Visitation : NSObject
{
    id allVisited;
    id grid;
    id visitor;
    NSInteger cursor;
    NSInteger dimension;
}
+visitationOnGrid:aGrid ofDimension:(NSInteger)n byVisitor:aVisitor;
-visitNext;
-visitedGrid;
@end
