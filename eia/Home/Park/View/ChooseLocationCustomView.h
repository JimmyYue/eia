//
//  ChooseLocationCustomView.h
//  HouseKeeper
//
//  Created by JimmyYue on 2019/5/23.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ChooseLocationCustomView;

@protocol ChooseLocationCustomViewDelegate <NSObject>

@optional

- (void)setCloseBtnAction:(ChooseLocationCustomView *)view;

- (void)setChooseLocationCode:(ChooseLocationCustomView *)view dic:(NSMutableDictionary *)dic;

@end

@interface ChooseLocationCustomView : UIView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,assign)id<ChooseLocationCustomViewDelegate>delegate;

@property (nonatomic, strong) UIView *view;

@property (nonatomic, strong) NSString *chooseType; // 选择类型

@property (nonatomic, strong) NSMutableDictionary *chooseCodeDic;

@property (nonatomic, strong) NSMutableArray *arrayRegion;

@property (nonatomic, strong) NSMutableArray *arrayStreet;

@property (nonatomic, strong) NSMutableArray *arrayCommunity;

- (void)setAllowChooseLocationCustomView;

- (void)setChooseCityName:(NSString *)name cityCode:(NSString *)code;

@property (nonatomic, strong) UILabel *line;

- (IBAction)closeBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cityBtn;

- (IBAction)cityBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *regionBtn;

- (IBAction)regionBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *streetBtn;

- (IBAction)streetBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *communityBtn;

- (IBAction)communityBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
