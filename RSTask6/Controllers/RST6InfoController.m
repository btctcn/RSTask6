#import "RST6InfoController.h"

@implementation RST6InfoController

-(instancetype)init{
    self = [super init];
    if(self){
        self.title = @"Info";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                        image:[UIImage imageNamed:@"info_unselected"]
                                                selectedImage:[UIImage imageNamed:@"info_selected"]];
        self.tabBarItem.tag = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
