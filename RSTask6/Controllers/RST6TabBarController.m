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

@property (nonatomic, weak) id<PhotoDataSource> photoSource;

@end

@implementation RST6TabBarController

- (instancetype)initWithDataSource:(id<PhotoDataSource>)photoSource{
    _photoSource = photoSource;
    return [super init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoController    = [[RST6InfoController alloc] initWithDataSource:_photoSource];
    self.galleryController = [[RST6GalleryController alloc] initWithDataSource:_photoSource];
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
