//
//  CompanyPushPageView.m
//  eia
//
//  Created by JimmyYue on 2020/7/2.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "CompanyPushPageView.h"

@implementation CompanyPushPageView

- (void)setAllowCompanyPushPageView:(NSString *)totalPageCount start:(NSString *)start {
    
    self.totalPageCount = totalPageCount;
    
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    view.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
    [self addSubview:view];
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    [view addGestureRecognizer:labelTapGestureRecognizer];
    
    UIView *pushView = [[UIView alloc] initWithFrame:CGRectMake(30, (kDeviceHeight - 300) / 2, kDeviceWidth - 60, 260)];
    pushView.backgroundColor = [UIColor whiteColor];
    [pushView.layer setCornerRadius:8.0];
    [view addSubview:pushView];
    
    UITapGestureRecognizer *labelTapGestureRecognizerS = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInsideS:)];
    [pushView addGestureRecognizer:labelTapGestureRecognizerS];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, pushView.frame.size.width, 20)];
    titleLabel.text = @"请输入您要跳转的页码数";
    titleLabel.textColor = TabbarBlack_S;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [pushView addSubview:titleLabel];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.frame.origin.y + titleLabel.frame.size.height + 20, pushView.frame.size.width, 20)];
    countLabel.text = [NSString stringWithFormat:@"共%@页, 当前第%@页", totalPageCount, start];
    countLabel.textColor = ZitiColor;
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.font = [UIFont systemFontOfSize:15];
    [pushView addSubview:countLabel];
    
    self.pageText = [[UITextField alloc]initWithFrame:CGRectMake(40, countLabel.frame.origin.y + countLabel.frame.size.height + 5, pushView.frame.size.width - 80, 80)];
    self.pageText.textColor = [UIColor blackColor];
    self.pageText.font = [UIFont systemFontOfSize:25];
    self.pageText.backgroundColor = [UIColor whiteColor];
    self.pageText.textAlignment = NSTextAlignmentCenter;
    self.pageText.layer.borderWidth = 1;
    self.pageText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pageText.keyboardType = UIKeyboardTypeNumberPad;
    self.pageText.layer.borderColor = TableViewLineColor.CGColor;
    [pushView addSubview:self.pageText];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(self.pageText.frame.origin.x + 10, self.pageText.frame.origin.y + self.pageText.frame.size.height + 25, (self.pageText.frame.size.width - 35) / 2, 34);
    [cancelBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn.layer setCornerRadius:17.0];
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.borderColor = TabbarBlack_S.CGColor;
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [pushView addSubview:cancelBtn];
    
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushBtn setTitle:@"立即跳转" forState:UIControlStateNormal];
    pushBtn.frame = CGRectMake(cancelBtn.frame.origin.x + cancelBtn.frame.size.width + 15, self.pageText.frame.origin.y + self.pageText.frame.size.height + 25, (self.pageText.frame.size.width - 35) / 2, 34);
    [pushBtn setTitleColor:TabbarBlack_S forState:UIControlStateNormal];
    pushBtn.backgroundColor = [UIColor whiteColor];
    [pushBtn.layer setCornerRadius:17.0];
    pushBtn.layer.borderWidth = 1;
    pushBtn.layer.borderColor = TabbarBlack_S.CGColor;
    pushBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [pushBtn addTarget:self action:@selector(pushBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [pushView addSubview:pushBtn];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view.window addSubview:self];
        //  弹出
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.3;
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.values = values;
        [self.layer addAnimation:animation forKey:nil];
    });
}

- (void)cancelBtnAction {
    [self setRemoveView];
}

- (void)pushBtnAction {
    if ([self.pageText.text intValue] <= [self.totalPageCount intValue]) {
        if ([self.pageText.text intValue] == 0) {
            self.pageText.text = @"1";
        }
        self.block([self.pageText.text intValue]);
        [self setRemoveView];
    } else {
        [SVProgressHUD showInfoWithStatus:@"跳转页数不能大于总页数 !"];
    }
}

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    [self setRemoveView];
}

- (void)setRemoveView {
    [UIView animateWithDuration:0.5 animations:^{
        //  时间内执行的代码
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        //  过了这个时间后执行的代码
        [self removeFromSuperview];
    }];
}

-(void) labelTouchUpInsideS:(UITapGestureRecognizer *)recognizer{
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
