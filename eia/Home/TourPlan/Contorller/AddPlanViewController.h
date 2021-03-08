//
//  AddPlanViewController.h
//  eia
//
//  Created by JimmyYue on 2020/9/3.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkInHeaderView.h"
#import "ParkEnterprisesTableViewCell.h"
#import "EnterprisesDetailNoProductionViewController.h"
#import "ParkEnterprisesDetailViewController.h"
#import "AddEnterprisePlanViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddPlanViewController : InheritanceViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ParkInHeaderView *parkInHeaderView;
@property (nonatomic, strong) NSMutableArray *arrayListResult;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,copy)void (^block)(NSString *reload);

@end

NS_ASSUME_NONNULL_END
