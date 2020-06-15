#import "Cell.h"
#import "Grid.h"

@interface LivingCell : Cell
@end

@interface DeadCell : Cell
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
#pragma clang diagnostic ignored "-Wobjc-method-access"

@implementation Cell

static id livingCell;
static id deadCell;

+(void)load
{
    livingCell = [LivingCell new];
    deadCell = [DeadCell new];
}

+living { return livingCell; }
+dead { return deadCell; }

-(NSInteger)neighboursOnGrid:grid atX:(NSInteger)x y:(NSInteger)y
{
    return [[[grid neighboursOfX:x y:y]
             valueForKeyPath:@"@sum.population"]
            integerValue];
}

-tickOnGrid:grid atX:(NSInteger)x y:(NSInteger)y;
{
    return [[self performSelector:NSSelectorFromString(@"potentialStates")]
            objectAtIndex:
            [self neighboursOnGrid:grid atX:x y:y]];
}

@end

#pragma clang diagnostic pop

@implementation LivingCell

static id nextStatesFromLiving;

+(void)load
{
    nextStatesFromLiving = [[NSArray alloc] initWithObjects:
                            deadCell,
                            deadCell,
                            livingCell,
                            livingCell,
                            deadCell,
                            deadCell,
                            deadCell,
                            deadCell,
                            deadCell,
                            nil];
}

-potentialStates { return nextStatesFromLiving; }
-(NSInteger)population { return 1; }
-changePopulation { return [Cell dead]; }

@end

@implementation DeadCell

static id nextStatesFromDead;

+(void)load
{
    nextStatesFromDead = [[NSArray alloc] initWithObjects:
                          deadCell,
                          deadCell,
                          deadCell,
                          livingCell,
                          deadCell,
                          deadCell,
                          deadCell,
                          deadCell,
                          deadCell,
                          nil];
}

-potentialStates { return nextStatesFromDead; }
-(NSInteger)population { return 0; }
-changePopulation { return [Cell living]; }
@end
