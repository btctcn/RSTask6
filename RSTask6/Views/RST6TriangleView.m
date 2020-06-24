#import "RST6TriangleView.h"
#import "UIColor+Additions.h"

static const unsigned int color = 0x34C1A1;
static const unsigned int width = 70;

@interface RST6TriangleView ()

@property (nonatomic, strong) CAAnimation *rotationAnimation;

@end

@implementation RST6TriangleView

const NSString *RotationAnimation = @"rotationAnimation";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self startAnimationTriangle];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self startAnimationTriangle];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat *colorComponents = [[UIColor fromHex:color] getRGBComponents];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, 5.58, 70);
    CGContextAddLineToPoint(ctx, 86.41, 70);
    CGContextAddLineToPoint(ctx, 46, 0);
    CGContextClosePath(ctx);
    CGContextSetRGBFillColor(ctx, colorComponents[0], colorComponents[1], colorComponents[2], 1);
    CGContextFillPath(ctx);
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

-(void)startAnimationTriangle{
    [self initRotationAnimation];
    [self.layer addAnimation:_rotationAnimation forKey:RotationAnimation];
}


@end
