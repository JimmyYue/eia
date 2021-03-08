//
//  ImageDetailHeaderView.h
//  eia
//
//  Created by JimmyYue on 2020/6/20.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface ImageDetailHeaderView : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UIImageView *statusImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@property (strong, nonatomic) IBOutlet UIButton *takingPicturesBtn;

@property(nonatomic,copy)TapBlock block;

-(void)updateWithStatus:(int)status;

- (void)setAddUITapGestureRecognizer;

@end

NS_ASSUME_NONNULL_END
