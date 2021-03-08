//
//  ChooseLocationTopView.h
//  HouseKeeper
//
//  Created by JimmyYue on 2019/5/20.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ChooseLocationTopView;

@protocol ChooseLocationTopViewDelegate <NSObject>

@optional

- (void)setChooseCode:(ChooseLocationTopView *)view dic:(NSMutableDictionary *)dic;

@end

@interface ChooseLocationTopView : UIView

@property(nonatomic,assign)id<ChooseLocationTopViewDelegate>delegate;

- (void)setAllowChooseLocationTopView;

@property (nonatomic, strong) NSMutableArray *arrayHistory;

@property (nonatomic, strong) NSMutableArray *historyArrayBtn;

@property (weak, nonatomic) IBOutlet UIButton *histryFBtn;

@property (weak, nonatomic) IBOutlet UIButton *historySBtn;

@property (weak, nonatomic) IBOutlet UIButton *historyTBtn;

@property (weak, nonatomic) IBOutlet UIButton *historyForBtn;

@property (weak, nonatomic) IBOutlet UIButton *historyFifBtn;

@property (weak, nonatomic) IBOutlet UIButton *historySixBtn;


@end

NS_ASSUME_NONNULL_END
