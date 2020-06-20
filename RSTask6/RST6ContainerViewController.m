#import "RST6ContainerViewController.h"
#import "RST6StartViewController.h"
#import "RST6TabBarController.h"

@interface RST6ContainerViewController ()

@property (nonatomic, strong) RST6StartViewController *startViewController;
@property (nonatomic, strong) RST6TabBarController *tabBarController;

@end

@implementation RST6ContainerViewController

- (instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style
                  navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation
                                options:(NSDictionary<UIPageViewControllerOptionsKey, id> *)options{
    self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startViewController = [[RST6StartViewController alloc] initWithNibName:@"RST6StartView" bundle:nil];
    self.tabBarController = [RST6TabBarController new];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setViewControllers:@[self.startViewController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:true
                  completion:nil];
    
}
@end
