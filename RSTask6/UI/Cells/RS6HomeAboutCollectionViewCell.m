#import "RS6HomeAboutCollectionViewCell.h"
#import "UIApplication+Additions.h"
#import "RST6AppleLogoCollectionViewCell.h"
#import "RST6DeviceInfoCollectionViewCell.h"


@interface RS6HomeAboutCollectionViewCell ()
@property (nonatomic, strong) RST6AppleLogoCollectionViewCell  *appleLogoView;
@property (nonatomic, strong) RST6DeviceInfoCollectionViewCell *deviceInfoView;
@end

@implementation RS6HomeAboutCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_innerCollectionView setDataSource:self];
    [_innerCollectionView setDelegate:self];
    
    [_innerCollectionView registerNib:[UINib nibWithNibName:@"RST6AppleLogoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"appleLogo"];
    [_innerCollectionView registerNib:[UINib nibWithNibName:@"RST6DeviceInfoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"deviceInfo"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChanged:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)statusBarOrientationChanged:(NSNotification *)notification{
    [_innerCollectionView.collectionViewLayout invalidateLayout];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"appleLogo" forIndexPath:indexPath];
            break;
        case 1:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"deviceInfo" forIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    cell.backgroundColor=[UIColor greenColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return [self getSizeForAppleLogo:collectionView];
            break;
        case 1:
            return [self getSizeForDeviceInfo:collectionView];
            break;
    }
    return CGSizeZero;
}

-(CGSize) getSizeForAppleLogo:(UICollectionView*)collectionView{
    BOOL isVertical = UIApplication.sharedApplication.isPortraitOrientation;
    CGFloat width = isVertical ? collectionView.bounds.size.width/3.3 : collectionView.bounds.size.width;
    CGFloat height = isVertical ? collectionView.bounds.size.height : collectionView.bounds.size.height/3.1;
    return CGSizeMake(width, height);
}

-(CGSize) getSizeForDeviceInfo:(UICollectionView*)collectionView{
    BOOL isVertical = UIApplication.sharedApplication.isPortraitOrientation;
    CGFloat width = isVertical ? collectionView.bounds.size.width*2/3 : collectionView.bounds.size.width;
    CGFloat height = isVertical ? collectionView.bounds.size.height : collectionView.bounds.size.height*2/3;
    return CGSizeMake(width, height);
}

@end
