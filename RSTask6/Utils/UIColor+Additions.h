//
//  UIColor+Additions.h
//  RSTask6
//
//  Created by Andrey Butcitcyn on 22.06.2020.
//  Copyright © 2020 Andrey Butcitcyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Additions)
+(UIColor *)fromHex:(unsigned int) hexColor alpha:(CGFloat)alpha;
+(UIColor *)fromHex:(unsigned int) hexColor;
-(CGFloat*) getRGBComponents;
-(CGFloat)getAlphaComponent;
@end

NS_ASSUME_NONNULL_END
