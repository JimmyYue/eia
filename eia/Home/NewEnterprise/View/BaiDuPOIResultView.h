//
//  BaiDuPOIResultView.h
//  HouseKeeper
//
//  Created by JimmyYue on 2019/5/31.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddHosueAddressTableViewCell.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@class BaiDuPOIResultView;

@protocol BaiDuPOIResultViewDelegate <NSObject>

@optional

- (void)setLoadMoreData:(BaiDuPOIResultView *_Nonnull)view;

- (void)setChooseAddress:(BaiDuPOIResultView *_Nonnull)view index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface BaiDuPOIResultView : UIView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,assign)id<BaiDuPOIResultViewDelegate>delegate;

- (void)setAllowBaiDuPOIResultView;

@property (nonatomic, assign) NSInteger chooseIndex;

- (void)setLoadMoreData:(NSMutableArray *)result;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayListResult;


@end

NS_ASSUME_NONNULL_END
