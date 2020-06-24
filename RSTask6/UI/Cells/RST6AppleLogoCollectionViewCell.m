#import "RST6AppleLogoCollectionViewCell.h"

@implementation RST6AppleLogoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChanged:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    [self setupContraints];
}

-(void)setupContraints{
    BOOL isPortrait = UIApplication.sharedApplication.isPortraitOrientation;
    //[self.logoTrailingConstraint setActive:!isPortrait];
    [self.logoCenterXContraint setActive:!isPortrait];
    
}

- (void)statusBarOrientationChanged:(NSNotification *)notification{
    [self setupContraints];
}

@end
