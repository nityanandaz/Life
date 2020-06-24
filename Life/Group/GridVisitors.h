#import <Foundation/Foundation.h>

@protocol GridVisitor <NSObject>

-visitDenizen:denizen
       onGrid:grid
  ofDimension:(NSInteger)n
          atX:(NSInteger)x
            y:(NSInteger)y;

@end

@interface PopulateVisitor:NSObject <GridVisitor>
{ id replacementDenizen; }
+ populateWith:aDenizen;
@end

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
