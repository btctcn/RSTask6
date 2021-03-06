#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RST6GalleryCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, copy) NSString *representedAssetIdentifier;

@end

NS_ASSUME_NONNULL_END
