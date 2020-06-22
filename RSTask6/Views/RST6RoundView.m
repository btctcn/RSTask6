#import "RST6RoundView.h"
#import "UIColor+Additions.h"

static const unsigned int color = 0xEE686A;

@implementation RST6RoundView

- (void)drawRect:(CGRect)rect {
    CGFloat *colorComponents = [[UIColor fromHex:color] getRGBComponents];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetRGBFillColor(ctx, colorComponents[0], colorComponents[1], colorComponents[2], 1);
    CGContextFillPath(ctx);
}

@end
