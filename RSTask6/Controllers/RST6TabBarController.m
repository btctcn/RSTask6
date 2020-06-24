#import "RST6TabBarController.h"
#import "RST6InfoController.h"
#import "RST6HomeController.h"
#import "RST6GalleryController.h"

@interface RST6TabBarController ()
@property (nonatomic, strong) RST6InfoController    *infoController;
@property (nonatomic, strong) RST6GalleryController *galleryController;
@property (nonatomic, strong) RST6HomeController    *homeController;

@property (nonatomic, strong) UINavigationController *tab1NavigationController;
@property (nonatomic, strong) UINavigationController *tab2NavigationController;
@property (nonatomic, strong) UINavigationController *tab3NavigationController;

@end

@implementation RST6TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoController    = [RST6InfoController new];
    self.galleryController = [RST6GalleryController new];
    self.homeController    = [RST6HomeController new];
    
    self.tab1NavigationController = [[UINavigationController alloc]initWithRootViewController:self.infoController];
    self.tab2NavigationController = [[UINavigationController alloc]initWithRootViewController:self.galleryController];
    self.tab3NavigationController = [[UINavigationController alloc]initWithRootViewController:self.homeController];
    
    self.viewControllers = @[self.tab1NavigationController,
                             self.tab2NavigationController,
                             self.tab3NavigationController];
    
    self.selectedIndex = 1;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
