#import "AppDelegate.h"
#import "RST6StartViewController.h"
#import "RST6TabBarController.h"
#import "UIWindow+Additions.h"
#import "UIColor+Additions.h"
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface AppDelegate ()

@property (nonatomic, strong) RST6StartViewController *startController;
@property (nonatomic, strong) RST6TabBarController *tabController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [self registerToNotifications];
    [self setupAppearance];
    [self initWindow];
    return YES;
}

-(void) initWindow{
    self.startController = [RST6StartViewController new];
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    __weak UIWindow *weakWindow = self.window;
    __weak AppDelegate *weakSelf = self;
    self.startController.completionHandler = ^{
        weakSelf.tabController = [RST6TabBarController new];
        [weakWindow setRootViewController:weakSelf.tabController animated:YES];
    };
    self.window.rootViewController = self.startController;
    [self.window makeKeyAndVisible];
}

-(void) setupAppearance{
    UITabBar.appearance.barTintColor = UIColor.whiteColor;
    UITabBar.appearance.tintColor = [UIColor fromHex:0x101010];
    UINavigationBar.appearance.titleTextAttributes = @{
        NSForegroundColorAttributeName : [UIColor fromHex:0x101010],
        NSFontAttributeName : [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]
    };
    UINavigationBar.appearance.barTintColor = [UIColor fromHex:0xF9CC78];
}

- (void)registerToNotifications{
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(goToStartRequested:)
                                               name:GoToStartRequested
                                             object:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(openCVRequested:)
                                               name:OpenCVRequested
                                             object:nil];
}

- (void)goToStartRequested:(NSNotification *)notification{
    [self.window setRootViewController:self.startController animated:YES];
}

- (void)openCVRequested:(NSNotification *)notification{
    NSURL *cvUrl = [NSURL URLWithString:CVUrl];
    if([UIApplication.sharedApplication canOpenURL:cvUrl]){
        [UIApplication.sharedApplication openURL:cvUrl options:@{} completionHandler:nil];
    }
}
@end
