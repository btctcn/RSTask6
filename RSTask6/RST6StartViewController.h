//
//  RST6StartViewController.h
//  RSTask6
//
//  Created by Andrey Butcitcyn on 20.06.2020.
//  Copyright © 2020 Andrey Butcitcyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RST6StartViewController : UIViewController

@property(nonatomic, copy) void (^completionHandler)(void);

@end

NS_ASSUME_NONNULL_END
