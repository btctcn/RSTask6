#import "RS6HomeShapeCollectionViewCell.h"
#import "UIApplication+Additions.h"
#import "RST6TriangleView.h"
#import "RST6SquareView.h"
#import "RST6RoundView.h"

@interface RS6HomeShapeCollectionViewCell ()

typedef NS_ENUM(NSInteger, ShapeType) {
    Round,
    Square,
    Triangle
};

@end

@implementation RS6HomeShapeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_innerCollectionView setDataSource:self];
    [_innerCollectionView setDelegate:self];
    
    [_innerCollectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"shapeCell"];
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
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shapeCell" forIndexPath:indexPath];
    [self initCell:cell shapetype:(ShapeType)indexPath.row];
    cell.backgroundColor = UIColor.greenColor;
    return cell;
}

-(void)initCell:(UICollectionViewCell *)cell shapetype:(ShapeType)shapeType{
    UIView *innerView = nil;
    
    CGFloat width = 0;
    CGFloat centerDelta = 0;
    switch (shapeType) {
        case Triangle:
            innerView = [RST6TriangleView new];
            centerDelta = 12;
            width = 93;
            break;
        case Round:
            innerView = [RST6RoundView new];
            width = 70;
            break;
        case Square:
            innerView = [RST6SquareView new];
            width = 70;
            break;
    }
    
    if(innerView){
        innerView.backgroundColor = UIColor.whiteColor;
        innerView.translatesAutoresizingMaskIntoConstraints = NO;
        cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addSubview:innerView];
        [NSLayoutConstraint activateConstraints:@[
            [innerView.centerXAnchor constraintEqualToAnchor:cell.centerXAnchor],
            [innerView.centerYAnchor constraintEqualToAnchor:cell.centerYAnchor constant:centerDelta],
            [innerView.widthAnchor constraintEqualToConstant:width],
            [innerView.heightAnchor constraintEqualToConstant:width]
        ]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heightDelta = 0;
    if(indexPath.row == 1){
        heightDelta = -30;
    }
    
    if(indexPath.row == 2){
        heightDelta = 30;
    }
    BOOL isVertical = UIApplication.sharedApplication.isPortraitOrientation;
    CGFloat width = isVertical ? collectionView.bounds.size.width/3.3 : collectionView.bounds.size.width;
    CGFloat height = isVertical ? collectionView.bounds.size.height : collectionView.bounds.size.height/3.1 + heightDelta;
    
    return CGSizeMake(width, height);
}

@end
