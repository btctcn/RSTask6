#import "RST6SquareView.h"
#import "UIColor+Additions.h"

static const unsigned int color = 0x29C2D1;
static const unsigned int width = 70;

@interface RST6SquareView ()

@property (nonatomic, strong) CAAnimation *upDownAnimation;

@end

@implementation RST6SquareView

const NSString *UpDownAnimation = @"upDownAnimation";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self startAnimation];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self startAnimation];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat *colorComponents = [[UIColor fromHex:color] getRGBComponents];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinX(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextClosePath(ctx);
    CGContextSetRGBFillColor(ctx, colorComponents[0], colorComponents[1], colorComponents[2], 1);
    CGContextFillPath(ctx);
}

-(void)initUpDownAnumation{
    CABasicAnimation *upDownAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    upDownAnimation.additive = YES; // fromValue and toValue will be relative instead of absolute values
    upDownAnimation.fromValue = [NSValue valueWithCGPoint:CGPointZero];
    upDownAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.0, (CGFloat)width/-10)];
    upDownAnimation.autoreverses = YES;
    upDownAnimation.duration = 0.5;
    upDownAnimation.repeatCount = INFINITY;
    self.upDownAnimation = upDownAnimation;
}

-(void)startAnimation{
    [self initUpDownAnumation];
    [self.layer addAnimation:_upDownAnimation forKey:UpDownAnimation];
}

@end
