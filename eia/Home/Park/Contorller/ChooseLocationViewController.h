//
//  ChooseLocationViewController.h
//  HouseKeeper
//
//  Created by JimmyYue on 2019/5/22.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseLocationTopView.h"
#import "BATableView.h"
#import "ChooseLocationCustomView.h"
#import "PageViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChooseLocationViewController : PageViewController <BATableViewDelegate, ChooseLocationCustomViewDelegate, ChooseLocationTopViewDelegate>

@property (nonatomic, strong) ChooseLocationTopView *chooseLocationTopView;
@property (nonatomic, strong) ChooseLocationCustomView *chooseLocationCustomView;
@property (nonatomic, strong) BATableView *bATableView;

@property (nonatomic,copy)void (^block)(NSDictionary *dic);
@property (nonatomic, strong) NSString *chooseLevel;

@property (nonatomic, strong) NSMutableDictionary *chooseDic;
@property (nonatomic, strong) NSMutableArray *letterArray;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

NS_ASSUME_NONNULL_END
