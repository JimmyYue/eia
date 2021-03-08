//
//  ChooseLocationTopView.m
//  HouseKeeper
//
//  Created by JimmyYue on 2019/5/20.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ChooseLocationTopView.h"

@implementation ChooseLocationTopView

- (void)setAllowChooseLocationTopView {
    
    self.historyArrayBtn = [[NSMutableArray alloc] init];
    
    [self.historyArrayBtn addObject:self.histryFBtn];
    [self.histryFBtn addTarget:self action:@selector(historyAction:) forControlEvents:UIControlEventTouchUpInside];
    _histryFBtn.tag = 320;
    _histryFBtn.layer.borderWidth = 1.0f;
    _histryFBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.historyArrayBtn addObject:self.historySBtn];
    [self.historySBtn addTarget:self action:@selector(historyAction:) forControlEvents:UIControlEventTouchUpInside];
    _historySBtn.tag = 321;
    _historySBtn.layer.borderWidth = 1.0f;
    _historySBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.historyArrayBtn addObject:self.historyTBtn];
    [self.historyTBtn addTarget:self action:@selector(historyAction:) forControlEvents:UIControlEventTouchUpInside];
    _historyTBtn.tag = 322;
    _historyTBtn.layer.borderWidth = 1.0f;
     _historyTBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.historyArrayBtn addObject:self.historyForBtn];
    [self.historyForBtn addTarget:self action:@selector(historyAction:) forControlEvents:UIControlEventTouchUpInside];
    _historyForBtn.tag = 323;
    _historyForBtn.layer.borderWidth = 1.0f;
    _historyForBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.historyArrayBtn addObject:self.historyFifBtn];
    [self.historyFifBtn addTarget:self action:@selector(historyAction:) forControlEvents:UIControlEventTouchUpInside];
    _historyFifBtn.tag = 324;
    _historyFifBtn.layer.borderWidth = 1.0f;
    _historyFifBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.historyArrayBtn addObject:self.historySixBtn];
    [self.historySixBtn addTarget:self action:@selector(historyAction:) forControlEvents:UIControlEventTouchUpInside];
    _historySixBtn.tag = 325;
    _historySixBtn.layer.borderWidth = 1.0f;
    _historySixBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
    _arrayHistory = [[NSMutableArray alloc] init];
    _arrayHistory = [NSMutableArray arrayWithArray:[XYCommon GetUserDefault:@"HistoryArray"]];
    for (int i = 0; i < self.historyArrayBtn.count; i++) {
        UIButton *button = self.historyArrayBtn[i];
        if (_arrayHistory.count <= i) {
            button.hidden = YES;
        } else {
            if ([[_arrayHistory[i] allKeys] containsObject:@"communityName"]) {
                [button setTitle:_arrayHistory[i][@"communityName"] forState:UIControlStateNormal];
            } else if ([[_arrayHistory[i] allKeys] containsObject:@"streetName"]) {
                [button setTitle:_arrayHistory[i][@"streetName"] forState:UIControlStateNormal];
            } else if ([[_arrayHistory[i] allKeys] containsObject:@"regionName"]) {
                [button setTitle:_arrayHistory[i][@"regionName"] forState:UIControlStateNormal];
            } else if ([[_arrayHistory[i] allKeys] containsObject:@"cityName"]) {
                [button setTitle:_arrayHistory[i][@"cityName"] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)historyAction:(UIButton *)button {
    [self setClearHistory];
    button.layer.borderColor = TabbarBlack_S.CGColor;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic = _arrayHistory[button.tag - 320];
    if ([self.delegate respondsToSelector:@selector(setChooseCode:dic:)]) {
        [self.delegate setChooseCode:self dic:dic];
    }
}



- (void)setClearHistory {
    for (int i = 0; i < self.historyArrayBtn.count; i++) {
        UIButton *button = self.historyArrayBtn[i];
        button.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
