#import "AppDelegate.h"
#import "RST6StartViewController.h"
#import "UIWindow+Additions.h"
#import "RST6TabBarController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
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
