#import <UIKit/UIKit.h>
#import "RST6GalleryFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface RST6GalleryView : UIView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet RST6GalleryFlowLayout *flowLayout;

@end

NS_ASSUME_NONNULL_END
