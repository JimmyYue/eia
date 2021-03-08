//
//  HomeSearchViewController.h
//  eia
//
//  Created by JimmyYue on 2020/4/21.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchEnterpriseTableViewCell.h"
#import "HomeSearchTableViewCell.h"
#import "ParkDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeSearchViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *searchText;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSMutableArray *arrayListResult;
@property (nonatomic,copy)void (^block)(NSDictionary *dic);
@end

NS_ASSUME_NONNULL_END
