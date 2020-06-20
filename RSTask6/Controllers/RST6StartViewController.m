#import "RST6StartViewController.h"
#import "RST6StartView.h"

@implementation RST6StartViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [[self viewAsRST6StartView].startButton addTarget:self  action:@selector(startButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) startButtonTouched:(UIButton *)sender{
    if(_completionHandler){
        _completionHandler();
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(RST6StartView *)viewAsRST6StartView{
    return (RST6StartView*)self.view;
}

@end
