//
//  PhotographCollectionViewCell.h
//  eia
//
//  Created by JimmyYue on 2020/4/28.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotographCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewP;

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;

@end

NS_ASSUME_NONNULL_END
