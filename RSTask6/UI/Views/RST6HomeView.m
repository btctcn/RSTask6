#import "RST6HomeView.h"
#import "UIApplication+Additions.h"
#import "UIColor+Additions.h"


@implementation RST6HomeView

- (void)completeInit{
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"RS6HomeAboutCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"about"];
    [_collectionView registerNib:[UINib nibWithNibName:@"RS6HomeShapeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"shape"];
    [_collectionView registerNib:[UINib nibWithNibName:@"RS6HomeActionsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"actions"];
    
    [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"delimeter"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChanged:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)statusBarOrientationChanged:(NSNotification *)notification{
    [_collectionView.collectionViewLayout invalidateLayout];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"about" forIndexPath:indexPath];
            break;
        case 2:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shape" forIndexPath:indexPath];
            break;
        case 4:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"actions" forIndexPath:indexPath];
            break;
        case 1:
        case 3:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"delimeter" forIndexPath:indexPath];
            cell.contentView.backgroundColor = [UIColor fromHex:0x979797];
            break;
        default:
            break;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isVertical =  UIApplication.sharedApplication.isPortraitOrientation;
    if(indexPath.row %2 == 0){
        BOOL isVertical =  UIApplication.sharedApplication.isPortraitOrientation;
        CGFloat width = isVertical ? collectionView.bounds.size.width : collectionView.bounds.size.width/3.1;
        CGFloat height = isVertical ? collectionView.bounds.size.height/3.1 : collectionView.bounds.size.height;
        return CGSizeMake(width, height);
    }
    else{
        CGFloat scaledOne = 1 / UIScreen.mainScreen.scale;
        CGFloat width = isVertical ? collectionView.bounds.size.width - 30: scaledOne;
        CGFloat height = isVertical ? scaledOne : collectionView.bounds.size.height - 30;
        
        return CGSizeMake(width, height);
    }
}

@end
