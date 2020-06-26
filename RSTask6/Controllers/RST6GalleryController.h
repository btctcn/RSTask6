#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Photos/Photos.h>
#import <QuickLook/QuickLook.h>

NS_ASSUME_NONNULL_BEGIN

@interface RST6GalleryController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PHPhotoLibraryChangeObserver>

- (instancetype)initWithDataSource:(id<PhotoDataSource>)photoSource;

@end

NS_ASSUME_NONNULL_END
