#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RS6HomeAboutCollectionViewCell : UICollectionViewCell <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *innerCollectionView;

@end

NS_ASSUME_NONNULL_END
