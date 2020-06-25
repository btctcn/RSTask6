#import "RST6InfoController.h"

@interface RST6InfoController ()

@property (nonatomic, weak) id<PhotoDataSource> photoSource;

@end

@implementation RST6InfoController

- (instancetype)initWithDataSource:(id<PhotoDataSource>)photosSource{
    self = [self init];
    if(self){
        _photoSource = photosSource;
    }
    return self;
}
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
