//
//  UIWindow+UIWindowAdditions.m
//  RSTask6
//
//  Created by Andrey Butcitcyn on 20.06.2020.
//  Copyright © 2020 Andrey Butcitcyn. All rights reserved.
//

#import "UIWindow+Additions.h"

@implementation UIWindow (Additions)

- (void)setRootViewController: (UIViewController *)rootViewController animated: (BOOL)animated
{
    UIView *snapShotView;

    if (animated)
    {
        snapShotView = [self snapshotViewAfterScreenUpdates: YES];
        [rootViewController.view addSubview: snapShotView];
    }

    [self setRootViewController: rootViewController];

    if (animated)
    {
        [UIView animateWithDuration: 0.3 animations:^{

            snapShotView.layer.opacity = 0;
            snapShotView.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);

        } completion:^(BOOL finished) {

            [snapShotView removeFromSuperview];

        }];
    }
}

@end
