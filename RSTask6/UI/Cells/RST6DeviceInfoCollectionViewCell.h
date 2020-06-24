#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RST6DeviceInfoCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2CenterXContraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2LeadingConstraint;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceIdiomLabel;
@property (weak, nonatomic) IBOutlet UILabel *osVersionLabel;

@end

NS_ASSUME_NONNULL_END
