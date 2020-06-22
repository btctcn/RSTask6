#import "RST6HomeController.h"

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
}

@end
