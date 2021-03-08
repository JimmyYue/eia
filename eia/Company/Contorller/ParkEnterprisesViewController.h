//
//  ParkEnterprisesViewController.h
//  eia
//
//  Created by JimmyYue on 2020/6/20.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkModel.h"
#import "ParkEnterprisesTableViewCell.h"
#import "ParkEnterprisesDetailViewController.h"
#import "EnterprisesDetailNoProductionViewController.h"
#import "CompanyBottomView.h"
#import "CompanyPushPageView.h"
#import "SortView.h"
#import "CommpanySearchViewController.h"
#import "AddPatrolViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParkEnterprisesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) NSString *needAmend;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int start;
@property (nonatomic, strong) CompanyBottomView *companyBottomView;
@property (nonatomic, strong) NSMutableArray *arrayListResult;
@property (nonatomic, strong) UITextField *searchText;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) NSMutableArray *arrayBtn;
@property (nonatomic, strong) NSString *totalPageCount;
@property (nonatomic, strong) NSMutableDictionary *searchDic;
@property (nonatomic, strong) NSString *sortsIndex;
@property (nonatomic, strong) NSString *orderBy;
@end

NS_ASSUME_NONNULL_END
