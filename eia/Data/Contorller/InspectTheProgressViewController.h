//
//  InspectTheProgressViewController.h
//  eia
//
//  Created by JimmyYue on 2020/7/8.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InspectTheProgressHeaderView.h"
#import "DataType1TableViewCell.h"
#import "DataType2TableViewCell.h"


NS_ASSUME_NONNULL_BEGIN

@interface InspectTheProgressViewController : InheritanceViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *createTimeStartF;
@property (nonatomic, strong) NSString *createTimeEndF;
@property (nonatomic, strong) NSString *createTimeStartS;
@property (nonatomic, strong) NSString *createTimeEndS;

@property (nonatomic, strong) NSMutableArray *reportEntityListF;
@property (nonatomic, strong) NSMutableArray *tableHeadListF;
@property (nonatomic, strong) NSMutableArray *reportEntityListS;
@property (nonatomic, strong) NSMutableArray *tableHeadListS;

@end

NS_ASSUME_NONNULL_END
