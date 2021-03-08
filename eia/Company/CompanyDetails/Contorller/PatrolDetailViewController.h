//
//  PatrolDetailViewController.h
//  eia
//
//  Created by JimmyYue on 2020/6/22.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotographCollectionViewCell.h"
#import "PatrolDetailHearerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PatrolDetailViewController : InheritanceViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) UICollectionView *photoCollectionView;
@property (nonatomic, strong) PatrolDetailHearerView * headerView;
@property (nonatomic, strong) NSMutableArray *arrayImage;
@property (nonatomic, assign) float height;
@end

NS_ASSUME_NONNULL_END
