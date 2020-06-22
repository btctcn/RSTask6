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
const NSString *RotationAnimation = @"rotationAnimation";
const NSString *PulseAnimation = @"pulseAnimation";
const NSString *UpDownAnimation = @"pulseAnimation";
const NSString *OpacityAnimation = @"opacityAnimation";

-(void)initView{
    self.roundView.layer.opacity = 0;
    self.sqrView.layer.opacity = 0;
    self.triangleView.layer.opacity = 0;
    [self initAnimations];
    
    [self.startButton addTarget:self  action:@selector(startButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initAnimations{
    [self initRotationAnimation];
    [self initOpacityAnimation];
    [self initPulseAnimation];
    [self initUpDownAnumation];
}

-(void)initPulseAnimation{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D enlarge = CATransform3DIdentity;
    enlarge = CATransform3DScale(enlarge, 1.1, 1.1, 1);
    
    CATransform3D reduce = CATransform3DIdentity;
    reduce = CATransform3DScale(enlarge, 0.9, 0.9, 1);
    
    pulseAnimation.fromValue = [NSValue valueWithCATransform3D:reduce];
    pulseAnimation.toValue = [NSValue valueWithCATransform3D:enlarge];
    
    pulseAnimation.duration = 0.5;
    pulseAnimation.repeatCount = HUGE_VALF;
    pulseAnimation.removedOnCompletion = NO;
    pulseAnimation.cumulative = NO;
    pulseAnimation.autoreverses = YES;
    self.pulseAnimation = pulseAnimation;
}

-(void)initRotationAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = 8;
    rotationAnimation.cumulative = NO;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.removedOnCompletion = NO;
    self.rotationAnimation = rotationAnimation;
}

-(void)initOpacityAnimation{
    CABasicAnimation* opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.duration = 1;
    self.opacityAnimation = opacityAnimation;
}

-(void)initUpDownAnumation{
    CABasicAnimation *upDownAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    CGFloat midY = CGRectGetMidY(self.sqrView.frame);
    CGFloat delta = self.sqrView.frame.size.width * 0.1;
    upDownAnimation.fromValue = [NSNumber numberWithFloat:midY - delta];
    upDownAnimation.toValue =   [NSNumber numberWithFloat:midY + delta];
    
    upDownAnimation.duration = 0.5;
    upDownAnimation.repeatCount = HUGE_VALF;
    upDownAnimation.removedOnCompletion = NO;
    upDownAnimation.cumulative = NO;
    upDownAnimation.autoreverses = YES;
    self.upDownAnimation = upDownAnimation;
}

-(void)startAnimations{
    if(_isAnimating) return;
    
    _isAnimating = !_isAnimating;
    
    [self addOpacityAnimation:self.roundView];
    [self addOpacityAnimation:self.sqrView];
    [self addOpacityAnimation:self.triangleView];
    
    [self startAnimationTriangle];
    [self startAnimationRound];
    [self startAnimationSquare];
}

-(void)startAnimationTriangle{
    [self.triangleView.layer addAnimation:_rotationAnimation forKey:RotationAnimation];
}

-(void)startAnimationRound{
    [self.roundView.layer addAnimation:_pulseAnimation forKey:PulseAnimation];
}

-(void)startAnimationSquare{
    [self.sqrView.layer addAnimation:_upDownAnimation forKey:UpDownAnimation];
}

-(void)addOpacityAnimation:(UIView*)view{
    CAAnimation *opacityAnimation = [self.opacityAnimation copy];
    opacityAnimation.delegate = view;
    [view.layer addAnimation:opacityAnimation forKey:OpacityAnimation];
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

@end
