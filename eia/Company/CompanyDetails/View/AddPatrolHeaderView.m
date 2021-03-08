//
//  AddPatrolHeaderView.m
//  eia
//
//  Created by JimmyYue on 2020/6/23.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "AddPatrolHeaderView.h"

@implementation AddPatrolHeaderView

- (void)setAllowAddPatrolHeaderView {
    
    UIView *purposeTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.purposeText.leftView = purposeTextView;
    self.purposeText.leftViewMode = UITextFieldViewModeAlways;
    
    [self.status1Btn addTarget:self action:@selector(statusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.status2Btn addTarget:self action:@selector(statusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.status3Btn addTarget:self action:@selector(statusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.status4Btn addTarget:self action:@selector(statusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.status5Btn addTarget:self action:@selector(statusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.perfectBtn addTarget:self action:@selector(resultBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rectificationBtn addTarget:self action:@selector(resultBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.riskBtn addTarget:self action:@selector(resultBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.signatureBtnNeed.selected = NO;
    self.needSign = @(true);
    [self.signatureBtnNeed addTarget:self action:@selector(signatureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.opinionText = [XBTextView textViewWithPlaceHolder:@"填写本次检查的结果说明"];
    self.opinionText.frame = CGRectMake(10, 225, kDeviceWidth - 30, 120);
    self.opinionText.maxTextCount = 2000;
    self.opinionText.textView.backgroundColor = BackgroundBlack;
    self.opinionText.layer.cornerRadius = 8.0f;
    self.opinionText.textView.font = [UIFont systemFontOfSize:15];
    self.opinionText.textCountLabel.hidden = YES;
    self.opinionText.backgroundColor = BackgroundBlack;
    [self addSubview:self.opinionText];
    
}

- (void)statusBtnAction:(UIButton *)button {;
    if (self.statusChooseBtn.selected == YES) {
        self.statusChooseBtn.selected = NO;
    }
    button.selected = YES;
    self.statusChooseBtn = button;
    
    if (button.tag == 400) {
        self.engageType = @"normal";
    } else if (button.tag == 401) {
        self.engageType = @"decoration";
    } else if (button.tag == 402) {
        self.engageType = @"planToMove";
    } else if (button.tag == 403) {
        self.engageType = @"outToMove";
    } else if (button.tag == 404) {
        self.engageType = @"onlyList";
    }
}

- (void)resultBtnAction:(UIButton *)button {
    if (self.opinionChooseBtn.selected == YES) {
           self.opinionChooseBtn.selected = NO;
       }
       button.selected = YES;
       self.opinionChooseBtn = button;
       
       if (button.tag == 500) {
           self.resultsType = @"normal";
       } else if (button.tag == 501) {
           self.resultsType = @"commonEdit";
       } else if (button.tag == 502) {
           self.resultsType = @"focusEdit";
       } 
}

- (void)signatureBtnAction {
    if (self.signatureBtnNeed.selected == NO) {
        self.signatureBtnNeed.selected = YES;
        self.needSign = @(false);
        self.signatureBtn.backgroundColor = BackgroundBlack;
        self.signatureBtn.userInteractionEnabled = NO;
    } else {
        self.signatureBtnNeed.selected = NO;
        self.needSign = @(true);
        self.signatureBtn.backgroundColor = [UIColor clearColor];
        self.signatureBtn.userInteractionEnabled = YES;
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
