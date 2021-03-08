//
//  ImageInformationView.h
//  eia
//
//  Created by JimmyYue on 2020/7/13.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotographCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageInformationView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *sectionStatus;//开关状态
@property (nonatomic, strong) UICollectionView *photoCollectionView;

- (void)setUpdateImageInformationView:(NSDictionary *)dic;
- (void)setAllowImageInformationView:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
