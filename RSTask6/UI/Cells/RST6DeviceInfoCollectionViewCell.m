#import "RST6DeviceInfoCollectionViewCell.h"
#import "UIApplication+Additions.h"

@implementation RST6DeviceInfoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChanged:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    [self setupContraints];
    
    _deviceNameLabel.text = UIDevice.currentDevice.name;
    NSString *deviceIdiom;
    switch (UIDevice.currentDevice.userInterfaceIdiom) {
        case UIUserInterfaceIdiomPhone:
            deviceIdiom = @"iPhone";
            break;
            case UIUserInterfaceIdiomPad:
            deviceIdiom = @"iPad";
            break;
        default:
            break;
    }
    _deviceIdiomLabel.text = deviceIdiom;
    _osVersionLabel.text = [NSString stringWithFormat:@"iOS %@", UIDevice.currentDevice.systemVersion];
}

-(void)setupContraints{
    BOOL isPortrait = UIApplication.sharedApplication.isPortraitOrientation;
    [self.label2CenterXContraint setActive:!isPortrait];
}

- (void)statusBarOrientationChanged:(NSNotification *)notification{
    [self setupContraints];
}

@end
