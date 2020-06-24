#import "RST6StartView.h"
#import "UIColor+Additions.h"

@interface RST6StartView ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIView *roundView;
@property (weak, nonatomic) IBOutlet UIView *sqrView;
@property (weak, nonatomic) IBOutlet UIView *triangleView;
@property (nonatomic, assign) BOOL isAnimating;
@end

@implementation RST6StartView

-(void)initView{
    self.roundView.layer.opacity = 0;
    self.sqrView.layer.opacity = 0;
    self.triangleView.layer.opacity = 0;
    
    [self.startButton addTarget:self  action:@selector(startButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) startButtonTouched:(UIButton *)sender{
    if(_startButtonPressedHandler){
        _startButtonPressedHandler();
    }
}

@end
