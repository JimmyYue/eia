//
//  CraftView.h
//  eia
//
//  Created by JimmyYue on 2020/4/22.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CraftView : UIView

@property (strong, nonatomic) IBOutlet UIButton *imageBtn;

@property (nonatomic, strong) UIView *selfView;
@property (nonatomic, strong) UIViewController *view;

@property(nonatomic, strong) XBTextView *speciesText;
@property(nonatomic, strong) XBTextView *productionText;
@property(nonatomic, strong) XBTextView *riskText;

- (void)setAllowCraftView;

@end

NS_ASSUME_NONNULL_END
