#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface RST6PreviewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *creationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) PHAsset *asset;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
- (IBAction)shareButtonTouched:(id)sender;

@end

NS_ASSUME_NONNULL_END
