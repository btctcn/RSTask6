#import "RST6HomeView.h"
#import "UIApplication+Additions.h"


@implementation RST6HomeView

- (void)completeInit{
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"RS6HomeAboutCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"about"];
    [_collectionView registerNib:[UINib nibWithNibName:@"RS6HomeShapeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"shape"];
    [_collectionView registerNib:[UINib nibWithNibName:@"RS6HomeActionsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"actions"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"about" forIndexPath:indexPath];
            break;
        case 1:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shape" forIndexPath:indexPath];
            break;
        case 2:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"actions" forIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    cell.backgroundColor=[UIColor greenColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isVertical =  UIApplication.sharedApplication.isPortraitOrientation;
    CGFloat width = isVertical ? collectionView.bounds.size.width : collectionView.bounds.size.width/3.1;
    CGFloat height = isVertical ? collectionView.bounds.size.height/3.1 : collectionView.bounds.size.height;
    
    return CGSizeMake(width, height);
}

@end
