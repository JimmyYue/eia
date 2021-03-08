//
//  PatrolRecordView.h
//  eia
//
//  Created by JimmyYue on 2020/7/13.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatrolRecordTableViewCell.h"
#import "PatrolDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PatrolRecordView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *Id;
@property (nonatomic,strong) UIViewController *view;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, strong) NSString *refreshStr;
@property (nonatomic, strong) NSMutableArray *arrayListResult;

- (void)setUpdatePatrolRecordView;
- (void)setAllowPatrolRecordView:(NSString *)Id;

@end

NS_ASSUME_NONNULL_END
