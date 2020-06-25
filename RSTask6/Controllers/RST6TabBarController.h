#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface RST6TabBarController : UITabBarController
-(instancetype)initWithDataSource:(id<PhotoDataSource>)photosSource;
@end

NS_ASSUME_NONNULL_END
