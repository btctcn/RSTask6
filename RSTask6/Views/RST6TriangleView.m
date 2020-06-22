#import "RST6TriangleView.h"
#import "UIColor+Additions.h"

static const unsigned int color = 0x34C1A1;

@implementation RST6TriangleView

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

@end
