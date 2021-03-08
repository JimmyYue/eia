//
//  ParkManagementViewController.h
//  eia
//
//  Created by JimmyYue on 2020/4/29.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkManagementTableViewCell.h"
#import "NewParkViewController.h"
#import "ParkManagementModel.h"
#import "ParkDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParkManagementViewController : InheritanceViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, strong) NSString *refreshStr;
@property (nonatomic, strong) NSMutableArray *arrayListResult;

@end

NS_ASSUME_NONNULL_END
