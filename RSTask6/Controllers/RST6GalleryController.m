#import "RST6GalleryController.h"

@implementation RST6GalleryController

-(instancetype)init{
    self = [super init];
    if(self){
        self.title = @"Gallery";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                        image:[UIImage imageNamed:@"gallery_unselected"]
                                                selectedImage:[UIImage imageNamed:@"gallery_selected"]];
        self.tabBarItem.tag = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
