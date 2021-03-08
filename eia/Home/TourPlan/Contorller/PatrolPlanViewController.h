//
//  PatrolPlanViewController.h
//  eia
//
//  Created by JimmyYue on 2020/9/2.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TourPlanView.h"
#import "JJScrollTextLable.h"
#import "ParkEnterprisesTableViewCell.h"
#import "CompanyPushPageView.h"
#import "AddPatrolViewController.h"
#import "EnterprisesDetailNoProductionViewController.h"
#import "ParkEnterprisesDetailViewController.h"
#import "CompanyBottomView.h"
#import "AddPlanViewController.h"
#import "UnfinishedViewController.h"
#import "InThePlanViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PatrolPlanViewController : PageViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TourPlanView *tourPlanView;
@property (strong, nonatomic) JJScorllTextLable *jjLabel;

@property (nonatomic, strong) NSMutableArray *arrayListResult;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int start;
@property (nonatomic, strong) NSString *totalPageCount;
@property (nonatomic, strong) CompanyBottomView *companyBottomView;
@property (nonatomic, strong) NSMutableDictionary *searchDic;
@property (nonatomic, strong) NSString *sortsIndex;

@end

NS_ASSUME_NONNULL_END
