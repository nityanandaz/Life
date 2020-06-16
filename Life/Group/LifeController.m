#import "LifeController.h"
#import "Grid.h"
#import "GridView.h"
#import "Cell.h"

static const NSInteger gridSize = 15;

@interface LifeController ()

@property (readwrite, nonatomic, retain) id grid;

@end

@implementation LifeController

@synthesize grid, gridView;

- (void)awakeFromNib
{
    [self awakeFromGSMarkup];
}

-(void)awakeFromGSMarkup
{
    self.grid = [[Grid withSideLength:gridSize] fillWith:[Cell dead]];
    [gridView drawGrid:self.grid];
}

-changeCellAtRelativeX:(float)fractionX y:(float)fractionY
{
    NSInteger cellX = floor(fractionX * gridSize);
    NSInteger cellY = floor(fractionY * gridSize);
    self.grid = [grid atX:cellX y:cellY perform:@selector(changePopulation)];
    [gridView drawGrid:self.grid];
    return self;
}

-(IBAction)tick:sender
{
    self.grid = [grid tick];
    [gridView drawGrid:self.grid];
}

@end
