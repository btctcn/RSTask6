#import "RST6StartViewController.h"
#import "RST6StartView.h"

@interface RST6StartViewController ()

typedef void (^completion_handler_t)(void);
@property (nonatomic, readonly) RST6StartView *startView;

@end

@implementation RST6StartViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initCompletionHandler];
    [self.startView initView];
}

-(void)initCompletionHandler{
    __weak completion_handler_t weakCompletionHandler = _completionHandler;
    self.startView.startButtonPressedHandler = ^{
        if(weakCompletionHandler){
            weakCompletionHandler();
        }
    };
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(RST6StartView *)startView{
    return (RST6StartView*)self.view;
}

@end
