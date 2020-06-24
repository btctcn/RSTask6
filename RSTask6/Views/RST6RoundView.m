#import "RST6RoundView.h"
#import "UIColor+Additions.h"

static const unsigned int color = 0xEE686A;

@interface RST6RoundView ()

@property (nonatomic, strong) CAAnimation *pulseAnimation;

@end

@implementation RST6RoundView

const NSString *PulseAnimation = @"pulseAnimation";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self startAnimationRound];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self startAnimationRound];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    CGFloat *colorComponents = [[UIColor fromHex:color] getRGBComponents];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetRGBFillColor(ctx, colorComponents[0], colorComponents[1], colorComponents[2], 1);
    CGContextFillPath(ctx);
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

-(void)startAnimationRound{
    [self initPulseAnimation];
    [self.layer addAnimation:_pulseAnimation forKey:PulseAnimation];
}

@end
