#import "RST6InfoController.h"
#import "RST6InfoTableViewCell.h"
#import "RST6PreviewController.h"
#import "UIColor+Additions.h"
#include "NSIndexPath+Additions.h"

@interface RST6InfoController ()

@property (nonatomic, weak) id<PhotoDataSource> photoSource;
@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic, assign) CGSize thumbnailSize;

@end

@implementation RST6InfoController

- (instancetype)initWithDataSource:(id<PhotoDataSource>)photosSource{
    self = [self init];
    if(self){
        _photoSource = photosSource;
    }
    return self;
}
-(instancetype)init{
    self = [super init];
    if(self){
        _imageManager = [PHCachingImageManager new];
        self.title = @"Info";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                        image:[UIImage imageNamed:@"info_unselected"]
                                                selectedImage:[UIImage imageNamed:@"info_selected"]];
        self.tabBarItem.tag = 0;
    }
    
    CGFloat scale = UIScreen.mainScreen.scale;
    _thumbnailSize = CGSizeMake(75*scale, 75*scale);
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"RST6InfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    __weak typeof(self) welf = self;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [welf.photoSource initPhotoSource];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [welf.tableView reloadData];
            });
            [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:welf];
        }
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self updateCachedAssets];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateCachedAssets];
}

-(void)updateCachedAssets{
    if(PHPhotoLibrary.authorizationStatus != PHAuthorizationStatusAuthorized) return;
    [self.imageManager stopCachingImagesForAllAssets];
    CGPoint co = self.tableView.contentOffset;
    CGSize size = self.tableView.bounds.size;
    CGRect visibleRect = CGRectMake(co.x,co.y, size.width, size.height);
    NSMutableArray *fetchResultsForVisibleCells = [NSMutableArray new];
    
    [[self.tableView indexPathsForVisibleRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [fetchResultsForVisibleCells addObject:self.photoSource.fetchResult[obj.item]];
    }];
    [self.imageManager startCachingImagesForAssets:fetchResultsForVisibleCells targetSize:self.thumbnailSize contentMode:PHImageContentModeAspectFill options:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photoSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RST6InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PHAsset *asset = [self.photoSource.fetchResult objectAtIndex:indexPath.row];
    
    cell.representedAssetIdentifier = asset.localIdentifier;
    PHAssetResource *assetResource = [PHAssetResource assetResourcesForAsset:asset][0];
    
    __weak RST6InfoTableViewCell* weakCell = cell;
    
    [self.imageManager requestImageForAsset:asset targetSize:self.thumbnailSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if([weakCell.representedAssetIdentifier compare:asset.localIdentifier] == NSOrderedSame){
            if(result){
                weakCell.mainImageView.image = result;
            }
            else{
                weakCell.mainImageView.image = [UIImage imageNamed:@"audioGroup"];
            }
        }
    }];
    UIImage *mediaImage = nil;
    NSString *pixelSize = nil;
    NSString *duration = nil;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    switch (asset.mediaType) {
        case PHAssetMediaTypeImage:
            mediaImage = [UIImage imageNamed:@"image"];
            pixelSize = [NSString stringWithFormat:@"%@x%@", @(asset.pixelWidth), @(asset.pixelHeight)];
            break;
        case PHAssetMediaTypeVideo:
            mediaImage = [UIImage imageNamed:@"video"];
            pixelSize = [NSString stringWithFormat:@"%@x%@", @(asset.pixelWidth), @(asset.pixelHeight)];
            duration = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:asset.duration]];
            break;
        case PHAssetMediaTypeAudio:
            mediaImage = [UIImage imageNamed:@"audio"];
            duration = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:asset.duration]];
            break;
        default:
            mediaImage = [UIImage imageNamed:@"other"];
            break;
    }
    cell.nameLabel.text = assetResource.originalFilename;
    cell.sizeLabel.text = [NSString stringWithFormat:@"%@ %@", pixelSize ? pixelSize : @"", duration ? duration : @""];
    cell.auxImageView.image = mediaImage;
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor fromHex:0xFDF4E3];
    [cell setSelectedBackgroundView:bgColorView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PHAsset *asset = self.photoSource.fetchResult[indexPath.row];
    RST6PreviewController *previewController = [[RST6PreviewController alloc] initWithNibName:@"RST6PreviewController" bundle:nil];
    previewController.asset = asset;
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:previewController]  animated:true completion:nil];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if(section == 0) return 0;
//    return 5;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [UIView new];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance{
    PHFetchResultChangeDetails *changes = [changeInstance changeDetailsForFetchResult:self.photoSource.fetchResult];
    if(!changes) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.photoSource.fetchResult = changes.fetchResultAfterChanges;
        if(changes.hasIncrementalChanges){
            [self.tableView beginUpdates];
                NSIndexSet *removed = changes.removedIndexes;
                if(removed && removed.count > 0){
                    [self.tableView  deleteRowsAtIndexPaths:[NSIndexPath nsIndexPathArrayFromNSIndexSet:removed] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                NSIndexSet *inserted = changes.insertedIndexes;
                if(inserted && inserted.count > 0){
                    [self.tableView insertRowsAtIndexPaths:[NSIndexPath nsIndexPathArrayFromNSIndexSet:inserted] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                [changes enumerateMovesWithBlock:^(NSUInteger fromIndex, NSUInteger toIndex) {
                    [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0] toIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
                }];
                
                NSIndexSet *changedIndexes = changes.changedIndexes;
                if(changedIndexes && changedIndexes.count > 0){
                    [self.tableView reloadRowsAtIndexPaths:[NSIndexPath nsIndexPathArrayFromNSIndexSet:changedIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            [self.tableView endUpdates];
        }
        else{
            [self.tableView reloadData];
        }
        [self.imageManager stopCachingImagesForAllAssets];
    });
}

- (void)dealloc{
    [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
}

@end
