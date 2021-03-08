//
//  TheParkInViewController.h
//  eia
//
//  Created by JimmyYue on 2020/7/8.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkInHeaderView.h"
#import "InspectTheProgressHeaderView.h"
#import "DataType5TableViewCell.h"
#import "DataType6TableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheParkInViewController : InheritanceViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *arrayF;
@property (nonatomic, strong) NSMutableArray *arrayP;
@property (nonatomic, strong) NSString *parkIdF;
@property (nonatomic, strong) NSString *parkNameF;
@property (nonatomic, strong) NSString *parkId;
@property (nonatomic, strong) NSString *parkName;
@property (nonatomic, strong) NSString *industryId;
@property (nonatomic, strong) NSString *industryName;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *reportEntityListF;
@property (nonatomic, strong) NSMutableArray *tableHeadListF;
@property (nonatomic, strong) NSMutableArray *reportEntityListS;
@property (nonatomic, strong) NSMutableArray *tableHeadListS;

@end

NS_ASSUME_NONNULL_END
