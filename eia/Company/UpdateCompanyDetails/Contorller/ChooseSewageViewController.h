//
//  ChooseSewageViewController.h
//  eia
//
//  Created by JimmyYue on 2020/7/1.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseSewageTableViewCell.h"
#import "WasteGas.h"
#import "WasteWater.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChooseSewageViewController : InheritanceViewController< UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,copy)void (^block)(NSMutableArray *array);

@property (nonatomic, strong) NSMutableArray *arraySelected;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) UITextField *searchText;
@property (nonatomic, strong) NSMutableArray *arrayResult;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayChoose;

@end

NS_ASSUME_NONNULL_END
