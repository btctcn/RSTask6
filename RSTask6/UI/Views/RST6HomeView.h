#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RST6HomeView : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
-(void)completeInit;

@end

NS_ASSUME_NONNULL_END
