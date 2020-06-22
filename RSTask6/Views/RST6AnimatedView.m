#import "RST6AnimatedView.h"

@implementation RST6AnimatedView

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.layer.opacity = 1.0;
}

@end
