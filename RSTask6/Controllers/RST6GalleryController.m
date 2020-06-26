#import "RST6GalleryController.h"
#import "RST6GalleryView.h"
#import "RST6GalleryCollectionCell.h"
#import <Photos/Photos.h>
#import "NSIndexPath+Additions.h"
#import <QuickLook/QuickLook.h>
#import "RST6PreviewController.h"

@interface RST6GalleryController ()

@property (nonatomic, weak) id<PhotoDataSource> photoSource;
@property (nonatomic, readonly) RST6GalleryView *galleryView;
@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic, assign) CGSize thumbnailSize;
@property (nonatomic, strong) NSURL *previewUrl;

@end

@implementation RST6GalleryController

- (instancetype)initWithDataSource:(id<PhotoDataSource>)photoSource{
    self = [self init];
    if(self){
        _photoSource = photoSource;
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if(self){
        _imageManager = [PHCachingImageManager new];
        self.title = @"Gallery";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                        image:[UIImage imageNamed:@"gallery_unselected"]
                                                selectedImage:[UIImage imageNamed:@"gallery_selected"]];
        self.tabBarItem.tag = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [NSBundle.mainBundle loadNibNamed:@"RST6GalleryView" owner:nil options:nil][0];
    self.galleryView.collectionView.dataSource = self;
    self.galleryView.collectionView.delegate = self;
    [self.galleryView.collectionView registerNib:[UINib nibWithNibName:@"RST6GalleryCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    __weak typeof(self) welf = self;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:welf];
            [welf.photoSource initPhotoSource];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [welf.galleryView.collectionView reloadData];
            });
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChanged:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)statusBarOrientationChanged:(NSNotification *)notification{
    [self.galleryView.collectionView.collectionViewLayout invalidateLayout];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self updateCachedAssets];
    [self.galleryView.collectionView.collectionViewLayout invalidateLayout];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateCachedAssets];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self updateCachedAssets];
    }
}

-(void)updateCachedAssets{
    [self.imageManager stopCachingImagesForAllAssets];
    CGRect visibleRect = CGRectMake(self.galleryView.collectionView.contentOffset.x, self.galleryView.collectionView.contentOffset.y, self.galleryView.collectionView.bounds.size.width, self.galleryView.collectionView.bounds.size.width);
    NSMutableArray *fetchResultsForVisibleCells = [NSMutableArray new];
    
    [[self.galleryView.collectionView indexPathsForVisibleItems] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [fetchResultsForVisibleCells addObject:self.photoSource.fetchResult[obj.item]];
    }];
    [self.imageManager startCachingImagesForAssets:fetchResultsForVisibleCells targetSize:self.thumbnailSize contentMode:PHImageContentModeAspectFill options:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = [self.photoSource.fetchResult objectAtIndex:indexPath.item];
    RST6GalleryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.representedAssetIdentifier = asset.localIdentifier;
    __weak RST6GalleryCollectionCell* weakCell = cell;
    [self.imageManager requestImageForAsset:asset targetSize:self.thumbnailSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if([weakCell.representedAssetIdentifier compare:asset.localIdentifier] == NSOrderedSame){
            weakCell.imageView.image = result;
        }
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat size = MIN(collectionView.bounds.size.width, collectionView.bounds.size.height) / 3.1;
    return CGSizeMake(size, size);
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGFloat scale = UIScreen.mainScreen.scale;
    CGSize cellSize = self.galleryView.flowLayout.itemSize;
    self.thumbnailSize = CGSizeMake(cellSize.width*scale, cellSize.height*scale);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PHAsset *asset = self.photoSource.fetchResult[indexPath.item];
    RST6PreviewController *previewController = [[RST6PreviewController alloc] initWithNibName:@"RST6PreviewController" bundle:nil];
    previewController.asset = asset;
    
    
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:previewController]  animated:true completion:nil];
    //PHAsset *asset = self.photoSource.fetchResult[indexPath.item];
//    __weak typeof(self) welf = self;
//    [asset requestContentEditingInputWithOptions:[PHContentEditingInputRequestOptions new] completionHandler:^(PHContentEditingInput * _Nullable contentEditingInput, NSDictionary * _Nonnull info) {
//        welf.previewUrl = contentEditingInput.fullSizeImageURL;
//        [welf.previewUrl startAccessingSecurityScopedResource];
//        previewController.dataSource = welf;
//        [welf presentViewController:previewController animated:true completion:^{
//            //[welf.previewUrl stopAccessingSecurityScopedResource];
//        }];
//    }];
}

-(RST6GalleryView *)galleryView{
    return (RST6GalleryView*)self.view;
}

-(void)resetCachedAssets{
    [_imageManager stopCachingImagesForAllAssets];
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance{
    PHFetchResultChangeDetails *changes = [changeInstance changeDetailsForFetchResult:self.photoSource.fetchResult];
    if(!changes) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.photoSource.fetchResult = changes.fetchResultAfterChanges;
        if(changes.hasIncrementalChanges){
            [self.galleryView.collectionView performBatchUpdates:^{
                NSIndexSet *removed = changes.removedIndexes;
                if(removed && removed.count > 0){
                    [self.galleryView.collectionView deleteItemsAtIndexPaths:[NSIndexPath nsIndexPathArrayFromNSIndexSet:removed]];
                }
                NSIndexSet *inserted = changes.insertedIndexes;
                if(inserted && inserted.count > 0){
                    [self.galleryView.collectionView insertItemsAtIndexPaths:[NSIndexPath nsIndexPathArrayFromNSIndexSet:inserted]];
                }
                [changes enumerateMovesWithBlock:^(NSUInteger fromIndex, NSUInteger toIndex) {
                    [self.galleryView.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0] toIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
                }];
                
                NSIndexSet *changedIndexes = changes.changedIndexes;
                if(changedIndexes && changedIndexes.count > 0){
                    [self.galleryView.collectionView reloadItemsAtIndexPaths:[NSIndexPath nsIndexPathArrayFromNSIndexSet:changedIndexes]];
                }
            } completion:nil];
        }
        else{
            [self.galleryView.collectionView reloadData];
        }
        [self.imageManager stopCachingImagesForAllAssets];
    });
}
- (void)dealloc{
    [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
}

@end
