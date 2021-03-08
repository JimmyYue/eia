//
//  EiaFormalitiesViewController.h
//  eia
//
//  Created by JimmyYue on 2020/7/8.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InspectTheProgressHeaderView.h"
#import "DataType3TableViewCell.h"
#import "DataType4TableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EiaFormalitiesViewController : InheritanceViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *createTimeStart;
@property (nonatomic, strong) NSString *createTimeEnd;

@property (nonatomic, strong) NSMutableArray *reportEntityListF;
@property (nonatomic, strong) NSMutableArray *tableHeadListF;
@property (nonatomic, strong) NSMutableArray *reportEntityListS;
@property (nonatomic, strong) NSMutableArray *tableHeadListS;
@property (nonatomic, strong) NSMutableArray *reportEntityListT;
@property (nonatomic, strong) NSMutableArray *tableHeadListT;

@end

NS_ASSUME_NONNULL_END
