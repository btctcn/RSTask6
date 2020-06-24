//
//  RS6HomeAboutCollectionViewCell.h
//  RSTask6
//
//  Created by Andrey Butcitcyn on 24.06.2020.
//  Copyright © 2020 Andrey Butcitcyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RS6HomeAboutCollectionViewCell : UICollectionViewCell <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *innerCollectionView;

@end

NS_ASSUME_NONNULL_END
