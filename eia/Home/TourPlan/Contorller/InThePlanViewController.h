//
//  InThePlanViewController.h
//  eia
//
//  Created by JimmyYue on 2020/9/3.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkEnterprisesTableViewCell.h"
#import "ParkEnterprisesDetailViewController.h"
#import "EnterprisesDetailNoProductionViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InThePlanViewController : PageViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,copy)void (^block)(NSString *reload);
@property (nonatomic, strong) NSString *tourPlanStatus;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) NSString *tourPlanTime;
@property (nonatomic, strong) NSMutableArray *arrayListResult;
@property (nonatomic, strong) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
