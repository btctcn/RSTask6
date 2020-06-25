#import "RST6GalleryController.h"
#import "RST6GalleryView.h"
#import "RST6GalleryCollectionCell.h"
#import <Photos/Photos.h>
#import "NSIndexPath+Additions.h"

@interface RST6GalleryController ()

@property (nonatomic, weak) id<PhotoDataSource> photoSource;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, readonly) RST6GalleryView *galleryView;
@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, assign) CGRect previousPreheatRect;
@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic, assign) CGSize thumbnailSize;

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
        _previousPreheatRect = CGRectZero;
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
    [self.galleryView.collectionView registerClass:RST6GalleryCollectionCell.class forCellWithReuseIdentifier:@"cell"];
    
    [self.photoSource initPhotoSource];
    [self resetCachedAssets];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateCachedAssets];
    //[self.imageManager startCachingImagesForAssets:self.photoSource.fetchResult. targetSize:self.thumbnailSize contentMode:PHImageContentModeAspectFill options:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateCachedAssets];
}

-(void)updateCachedAssets{
//    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.width);
//    NSMutableArray<NSIndexPath *>* indexPaths = [NSMutableArray new];
//    [[self.collectionView indexPathsForVisibleItems] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [indexPaths addObject:obj];
//    }];
//    
//    self.imageManager start
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"self.photoSource.count = %@", @(self.photoSource.count));
    return self.photoSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = [self.photoSource.fetchResult objectAtIndex:indexPath.item];
    RST6GalleryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.representedAssetIdentifier = asset.localIdentifier;
    __weak RST6GalleryCollectionCell* weakCell = cell;
    [self.imageManager requestImageForAsset:asset targetSize:self.thumbnailSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if(weakCell.representedAssetIdentifier == asset.localIdentifier){
            weakCell.imageView.image = result;
            NSLog(@"%@", @"cell.thumbnailImage = image");
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

-(RST6GalleryView *)galleryView{
    return (RST6GalleryView*)self.view;
}

-(void)resetCachedAssets{
    [_imageManager stopCachingImagesForAllAssets];
    _previousPreheatRect = CGRectZero;
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance{
    PHFetchResultChangeDetails *changes = [changeInstance changeDetailsForFetchResult:self.photoSource.fetchResult];
    if(!changes) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.photoSource.fetchResult = changes.fetchResultAfterChanges;
        if(changes.hasIncrementalChanges){
            [self.collectionView performBatchUpdates:^{
                NSIndexSet *removed = changes.removedIndexes;
                if(removed && removed.count > 0){
                    [self.collectionView deleteItemsAtIndexPaths:[NSIndexPath nsIndexPathArrayFromNSIndexSet:removed]];
                }
                NSIndexSet *inserted = changes.insertedIndexes;
                if(inserted && inserted.count > 0){
                    [self.collectionView insertItemsAtIndexPaths:[NSIndexPath nsIndexPathArrayFromNSIndexSet:inserted]];
                }
                [changes enumerateMovesWithBlock:^(NSUInteger fromIndex, NSUInteger toIndex) {
                    [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0] toIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
                }];
                
                NSIndexSet *changedIndexes = changes.changedIndexes;
                if(changedIndexes && changedIndexes.count > 0){
                    [self.collectionView reloadItemsAtIndexPaths:[NSIndexPath nsIndexPathArrayFromNSIndexSet:changedIndexes]];
                }
            } completion:nil];
        }
        else{
            [self.collectionView reloadData];
        }
        [self resetCachedAssets];
    });
}
- (void)dealloc{
    [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
}

@end
