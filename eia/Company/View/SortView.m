//
//  SortView.m
//  eia
//
//  Created by JimmyYue on 2020/7/3.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "SortView.h"

@implementation SortView

- (void)setAllowSortView:(float)navRect index:(NSString *)index {
    
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    view.backgroundColor = RGBACOLOR(0, 0, 0, 0);
    [self addSubview:view];
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    [view addGestureRecognizer:labelTapGestureRecognizer];
    
    UIImageView *imageUp = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth - 135 + 80, navRect + StatusRect - 15, 30, 15)];
    imageUp.image = IMAGENAMED(@"up");
    [view addSubview:imageUp];
    
    UIView *pushView = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth - 135, navRect + StatusRect - 5, 120, 140)];
    pushView.backgroundColor = BackgroundBlack;
    [view addSubview:pushView];
    
    self.btnArray = [[NSMutableArray alloc] init];
    NSArray *array = @[@"导入时间先后", @"查询时间先后", @"档案更新先后"];
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 10 + i * 40, pushView.frame.size.width, 40);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 280 + i;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        if ([IsBlankString isBlankString:index] == NO) {
            if ([index isEqualToString:array[i]]) {
                btn.selected = YES;
            }
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:TabbarBlack_S forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [pushView addSubview:btn];
        
        [self.btnArray addObject:btn];
    }
    
    UITapGestureRecognizer *labelTapGestureRecognizerS = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInsideS:)];
    [pushView addGestureRecognizer:labelTapGestureRecognizerS];
  
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

- (void)btnAction:(UIButton*)button {
    for (int i = 0; i < self.btnArray.count; i++) {
        UIButton *btn = self.btnArray[i];
        btn.selected = NO;
    }
    if (button.tag == 280) {
        self.orderBy = @"create_time";
    } else if (button.tag == 281) {
        self.orderBy = @"follow_date_last";
    } else if (button.tag == 282) {
        self.orderBy = @"last_update_time";
    }
    button.selected = YES;
    self.block(self.orderBy, button.titleLabel.text);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
