#import "AppDelegate.h"
#import "RST6StartViewController.h"
#import "RST6TabBarController.h"
#import "UIWindow+Additions.h"
#import "UIColor+Additions.h"
#import <UIKit/UIKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    UITabBar.appearance.barTintColor = UIColor.whiteColor;
    UITabBar.appearance.tintColor = [UIColor fromHex:0x101010];
    UINavigationBar.appearance.titleTextAttributes = @{
        NSForegroundColorAttributeName : [UIColor fromHex:0x101010],
                   NSFontAttributeName : [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]
    };
    
    UINavigationBar.appearance.barTintColor = [UIColor fromHex:0xF9CC78];
    
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    RST6StartViewController *startController = [RST6StartViewController new];
    
    __weak UIWindow *weakWindow = self.window;
    startController.completionHandler = ^{
        [weakWindow setRootViewController:[RST6TabBarController new] animated:YES];
    };
    
    self.window.rootViewController = startController;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
