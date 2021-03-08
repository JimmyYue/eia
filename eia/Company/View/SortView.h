//
//  SortView.h
//  eia
//
//  Created by JimmyYue on 2020/7/3.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SortView : UIView

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSString *orderBy;
@property (nonatomic,copy)void (^block)(NSString *orderBy, NSString *sortsIndex);
- (void)setAllowSortView:(float)navRect index:(NSString *)index;
@property (nonatomic, strong) NSMutableArray *btnArray;

@end

NS_ASSUME_NONNULL_END
