#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <PhotosUI/PHLivePhotoView.h>

NS_ASSUME_NONNULL_BEGIN

@interface RST6PreviewController : UIViewController <PHLivePhotoViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *creationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) PHAsset *asset;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
- (IBAction)shareButtonTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet PHLivePhotoView *livePhotoView;

@end

NS_ASSUME_NONNULL_END
