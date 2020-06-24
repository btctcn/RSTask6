#import "RST6HomeController.h"
#import "RST6HomeView.h"

@interface RST6HomeController ()

@property (nonatomic, readonly) RST6HomeView *homeView;

@end


@implementation RST6HomeController

-(instancetype)init{
    self = [super init];
    if(self){
        self.title = @"RSSchool Task 6";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                        image:[UIImage imageNamed:@"home_unselected"]
                                                selectedImage:[UIImage imageNamed:@"home_selected"]];
        self.tabBarItem.tag = 2;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.view = [NSBundle.mainBundle loadNibNamed:@"RST6HomeView" owner:nil options:nil][0];
    [[self homeView] completeInit];
}

-(RST6HomeView *)homeView{
    return (RST6HomeView*)self.view;
}

@end
