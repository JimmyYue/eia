//
//  ChooseIndustryClassificationView.h
//  eia
//
//  Created by JimmyYue on 2020/6/30.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseIndustryClassificationView : UIView<UITableViewDelegate, UITableViewDataSource>

- (void)setAllowChooseIndustryClassificationViewFrame:(CGRect)frame array:(NSMutableArray *)array;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,copy)void (^block)(NSDictionary *dic);

@end

NS_ASSUME_NONNULL_END
