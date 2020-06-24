#import "RST6AnimatedView.h"

@interface RST6AnimatedView ()
@property (nonatomic, strong) CAAnimation *opacityAnimation;
@end

@implementation RST6AnimatedView

const NSString *OpacityAnimation = @"opacityAnimation";

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addOpacityAnimation];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addOpacityAnimation];
    }
    return self;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.layer.opacity = 1.0;
}

-(void)initOpacityAnimation{
    CABasicAnimation* opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.duration = 1;
    self.opacityAnimation = opacityAnimation;
}

-(void)addOpacityAnimation{
    [self initOpacityAnimation];
    self.opacityAnimation.delegate = self;
    [self.layer addAnimation:self.opacityAnimation forKey:OpacityAnimation];
}


@end
