//
//  UIApplication+Additions.m
//  RSTask6
//
//  Created by Andrey Butcitcyn on 24.06.2020.
//  Copyright © 2020 Andrey Butcitcyn. All rights reserved.
//

#import "UIApplication+Additions.h"

@implementation UIApplication (Additions)

- (BOOL)isPortraitOrientation{
    return self.statusBarOrientation == UIInterfaceOrientationPortrait ||
    self.statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown;
}

@end
