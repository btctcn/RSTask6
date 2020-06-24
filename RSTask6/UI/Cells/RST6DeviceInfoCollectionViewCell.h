#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RST6DeviceInfoCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2CenterXContraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2LeadingConstraint;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceIdiomLabel;
@property (weak, nonatomic) IBOutlet UILabel *osVersionLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2CenterYConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2TopConstraint;

@end

NS_ASSUME_NONNULL_END
