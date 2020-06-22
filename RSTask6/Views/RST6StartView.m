#import "RST6StartView.h"

@interface RST6StartView ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIView *roundView;
@property (weak, nonatomic) IBOutlet UIView *sqrView;
@property (weak, nonatomic) IBOutlet UIView *triangleView;

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, strong) CAAnimation *upDownAnimation;
@property (nonatomic, strong) CAAnimation *pulseAnimation;
@property (nonatomic, strong) CAAnimation *rotationAnimation;
@property (nonatomic, strong) CAAnimation *opacityAnimation;
@end

@implementation RST6StartView
const NSString *kRotationAnimation = @"rotationAnimation";
const NSString *kOpacityAnimation = @"opacityAnimation";

-(void)initView{
    self.roundView.layer.opacity = 0;
    self.sqrView.layer.opacity = 0;
    self.triangleView.layer.opacity = 0;
    [self initAnimations];
    
    [self.startButton addTarget:self  action:@selector(startButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initAnimations{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.removedOnCompletion = NO;
    
    self.rotationAnimation = rotationAnimation;
    
    CABasicAnimation* opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.duration = 1;
    opacityAnimation.delegate = self;
    self.opacityAnimation = opacityAnimation;
}

-(void)startAnimations{
    if(_isAnimating) return;
    
    _isAnimating = !_isAnimating;
    
    [self addOpacityAnimation:self.roundView];
    [self addOpacityAnimation:self.sqrView];
    [self addOpacityAnimation:self.triangleView];
    
    [self.roundView.layer addAnimation:_rotationAnimation forKey:kRotationAnimation];
}

-(void)addOpacityAnimation:(UIView*)view{
    CAAnimation *opacityAnimation = [self.opacityAnimation copy];
    opacityAnimation.delegate = view;
    [view.layer addAnimation:opacityAnimation forKey:kOpacityAnimation];
}

-(void)stopAnimations{
    if(!_isAnimating) return;
    
    _isAnimating = !_isAnimating;
}

-(void) startButtonTouched:(UIButton *)sender{
    if(_startButtonPressedHandler){
        _startButtonPressedHandler();
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%@", anim);
}

@end
