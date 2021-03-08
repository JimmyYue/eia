//
//  PollutionDetailView.h
//  eia
//
//  Created by JimmyYue on 2020/6/18.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PollutionTableViewCell.h"
#import "ContentTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PollutionDetailView : UIView<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) NSDictionary *resultDic;
@property (nonatomic, strong) NSMutableArray *sewageArray;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableFooterView;

- (void)setAllowPollutionDetailView:(NSDictionary *)dic;


@end

NS_ASSUME_NONNULL_END
