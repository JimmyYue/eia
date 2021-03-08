//
//  CompanyScreenView.m
//  eia
//
//  Created by JimmyYue on 2020/7/3.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "CompanyScreenView.h"

@implementation CompanyScreenView

- (IBAction)parkChooseBtnAction:(id)sender {
    HomeSearchViewController *homeSearchVC = [[HomeSearchViewController alloc] init];
    [homeSearchVC setBlock:^(NSDictionary * _Nonnull dic) {
        self.parkCode = [NSString stringWithFormat:@"%@", dic[@"id"]];
        self.parkText.text = [NSString stringWithFormat:@"%@", dic[@"parkName"]];
    }];
    homeSearchVC.type = @"choosePark";
    [self.view.navigationController pushViewController:homeSearchVC animated:YES];
}

- (IBAction)addStarTimeBtnAction:(id)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate * startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        [self.addStarTimeBtn setTitle:date forState:UIControlStateNormal];
    }];
    datepicker.doneButtonColor = TabbarBlack_S;
    datepicker.dateLabelColor = TabbarBlack_S;
    datepicker.minLimitDate = [NSDate date:@"2020-01-01" WithFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    datepicker.maxLimitDate = [NSDate date:dateTime WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
}

- (IBAction)addEndTimeBtnAction:(id)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate * startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        [self.addEndTimeBtn setTitle:date forState:UIControlStateNormal];
    }];
    datepicker.doneButtonColor = TabbarBlack_S;
    datepicker.dateLabelColor = TabbarBlack_S;
    datepicker.minLimitDate = [NSDate date:@"2020-01-01" WithFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    datepicker.maxLimitDate = [NSDate date:dateTime WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
}

- (IBAction)patrolStarTimeBtnAction:(id)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate * startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        [self.patrolStarTimeBtn setTitle:date forState:UIControlStateNormal];
    }];
    datepicker.doneButtonColor = TabbarBlack_S;
    datepicker.dateLabelColor = TabbarBlack_S;
    datepicker.minLimitDate = [NSDate date:@"2020-01-01" WithFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    datepicker.maxLimitDate = [NSDate date:dateTime WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
}

- (IBAction)patrolEndTimeBtnAction:(id)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate * startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        [self.patrolEndTimeBtn setTitle:date forState:UIControlStateNormal];
    }];
    datepicker.doneButtonColor = TabbarBlack_S;
    datepicker.dateLabelColor = TabbarBlack_S;
    datepicker.minLimitDate = [NSDate date:@"2020-01-01" WithFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    datepicker.maxLimitDate = [NSDate date:dateTime WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
}

- (IBAction)operatingStateBtnAction:(id)sender {
    UIButton *button =  (UIButton *)sender;
    if (self.operatingStateBtnChoose != button) {
        self.operatingStateBtnChoose.selected = NO;
        self.operatingStateBtnChoose = button;
        button.selected = YES;
        
        if (button.tag == 240) {
            self.engageType = @"normal";
        } else if (button.tag == 241) {
            self.engageType = @"decoration";
        } else if (button.tag == 242) {
            self.engageType = @"onlyList";
        } else if (button.tag == 243) {
            self.engageType = @"planToMove";
        } else if (button.tag == 244) {
            self.engageType = @"outToMove";
        }
    } else {
        self.operatingStateBtnChoose.selected = NO;
        self.operatingStateBtnChoose = self.nilButton;
        self.engageType = @"";
    }
}

- (IBAction)companyTypeBtnAction:(id)sender {
    UIButton *button =  (UIButton *)sender;
    if (self.companyTypeBtnChoose != button) {
        self.companyTypeBtnChoose.selected = NO;
        self.companyTypeBtnChoose = button;
        button.selected = YES;
        
        if (button.tag == 250) {
            self.enterpriseType = @"produce";
        } else if (button.tag == 251) {
            self.enterpriseType = @"produceNot";
        }
    } else {
        self.companyTypeBtnChoose.selected = NO;
        self.companyTypeBtnChoose = self.nilButton;
        self.enterpriseType = @"";
    }
}

- (IBAction)resultBtnAction:(id)sender {
    UIButton *button =  (UIButton *)sender;
    if (self.resultBtnChoose != button) {
        self.resultBtnChoose.selected = NO;
        self.resultBtnChoose = button;
        button.selected = YES;
        
        if (button.tag == 260) {
            self.resultsType = @"normal";
        } else if (button.tag == 261) {
            self.resultsType = @"commonEdit";
        } else if (button.tag == 262) {
            self.resultsType = @"focusEdit";
        }
    } else {
        self.resultBtnChoose.selected = NO;
        self.resultBtnChoose = self.nilButton;
        self.resultsType = @"";
    }
}

- (IBAction)userTypeBtnAction:(id)sender {
    UIButton *button =  (UIButton *)sender;
    if (self.userTypeBtnChoose != button) {
        self.userTypeBtnChoose.selected = NO;
        self.userTypeBtnChoose = button;
        button.selected = YES;
        
        if (button.tag == 270) {
            self.plantUseType = @"self";
        } else if (button.tag == 271) {
            self.plantUseType = @"rent";
        }
    } else {
        self.userTypeBtnChoose.selected = NO;
        self.userTypeBtnChoose = self.nilButton;
        self.plantUseType = @"";
    }
}

- (IBAction)eiaTypeBtnAction:(id)sender {
    UIButton *button =  (UIButton *)sender;
    if (self.eiaTypeBtnChoose != button) {
        self.eiaTypeBtnChoose.selected = NO;
        self.eiaTypeBtnChoose = button;
        button.selected = YES;
        
        if (button.tag == 280) {
            self.eiaSortType = @"reportBook";
        } else if (button.tag == 281) {
            self.eiaSortType = @"reportTable";
        } else if (button.tag == 282) {
            self.eiaSortType = @"registerTable";
        }
    } else {
        self.eiaTypeBtnChoose.selected = NO;
        self.eiaTypeBtnChoose = self.nilButton;
        self.eiaSortType = @"";
    }
}

- (IBAction)eiaStateBtnAction:(id)sender {
    UIButton *button =  (UIButton *)sender;
    if (self.eiaStateBtnChoose != button) {
        self.eiaStateBtnChoose.selected = NO;
        self.eiaStateBtnChoose = button;
        button.selected = YES;
        
        if (button.tag == 290) {
            self.eiaPaperType = @"process";
        } else if (button.tag == 291) {
            self.eiaPaperType = @"over";
        } else if (button.tag == 292) {
            self.eiaPaperType = @"notYet";
        } else if (button.tag == 293) {
            self.eiaPaperType = @"notNeed";
        }
    } else {
        self.eiaStateBtnChoose.selected = NO;
        self.eiaStateBtnChoose = self.nilButton;
        self.eiaPaperType = @"";
    }
}

- (IBAction)acceptanceStateBtnAction:(id)sender {
    UIButton *button =  (UIButton *)sender;
    if (self.acceptanceStateBtnChoose != button) {
        self.acceptanceStateBtnChoose.selected = NO;
        self.acceptanceStateBtnChoose = button;
        button.selected = YES;
        
        if (button.tag == 300) {
            self.checkPaperType = @"process";
        } else if (button.tag == 301) {
            self.checkPaperType = @"over";
        } else if (button.tag == 302) {
            self.checkPaperType = @"notYet";
        } else if (button.tag == 303) {
            self.checkPaperType = @"notNeed";
        }
    } else {
        self.acceptanceStateBtnChoose.selected = NO;
        self.acceptanceStateBtnChoose = self.nilButton;
        self.checkPaperType = @"";
    }
}

- (IBAction)wasteDisposalBtnAction:(id)sender {
    UIButton *button =  (UIButton *)sender;
    if (self.wasteDisposalBtnChoose != button) {
        self.wasteDisposalBtnChoose.selected = NO;
        self.wasteDisposalBtnChoose = button;
        button.selected = YES;
        
        if (button.tag == 310) {
             self.solidType = @"process";
        } else if (button.tag == 311) {
            self.solidType = @"over";
        } else if (button.tag == 312) {
             self.solidType = @"notYet";
        } else if (button.tag == 313) {
            self.solidType = @"notNeed";
        }
    } else {
        self.wasteDisposalBtnChoose.selected = NO;
        self.wasteDisposalBtnChoose = self.nilButton;
         self.solidType = @"";
    }
}

- (IBAction)blowdownCategoryBtnAction:(id)sender {
    UIButton *button =  (UIButton *)sender;
    if (self.blowdownCategoryBtnChoose != button) {
        self.blowdownCategoryBtnChoose.selected = NO;
        self.blowdownCategoryBtnChoose = button;
        button.selected = YES;
        
        if (button.tag == 320) {
            self.dirtyNatureType = @"register";
        } else if (button.tag == 321) {
            self.dirtyNatureType = @"focusModes";
        } else if (button.tag == 322) {
            self.dirtyNatureType = @"simple";
        }
    }  else {
        self.blowdownCategoryBtnChoose.selected = NO;
        self.blowdownCategoryBtnChoose = self.nilButton;
        self.dirtyNatureType = @"";
    }
}

- (IBAction)blowdownCategoryStateBtnAction:(id)sender {
    UIButton *button =  (UIButton *)sender;
    if (self.blowdownCategoryStateBtnChoose != button) {
        self.blowdownCategoryStateBtnChoose.selected = NO;
        self.blowdownCategoryStateBtnChoose = button;
        button.selected = YES;
        
        if (button.tag == 330) {
            self.dirtyLicenseType = @"process";
        } else if (button.tag == 331) {
            self.dirtyLicenseType = @"over";
        } else if (button.tag == 332) {
            self.dirtyLicenseType = @"notYet";
        } else if (button.tag == 333) {
            self.dirtyLicenseType = @"notNeed";
        }
    } else {
        self.blowdownCategoryStateBtnChoose.selected = NO;
        self.blowdownCategoryStateBtnChoose = self.nilButton;
        self.dirtyLicenseType = @"";
    }
}

- (IBAction)yesOrOnBtnAction:(id)sender {
    UIButton *button =  (UIButton *)sender;
    if (self.boolBtnChoose != button) {
        self.boolBtnChoose.selected = NO;
        self.boolBtnChoose = button;
        button.selected = YES;
        
        if (button.tag == 340) {
            self.hasDangerAllow = @"true";
        } else if (button.tag == 341) {
            self.hasDangerAllow = @"false";
        }
    } else {
        self.boolBtnChoose.selected = NO;
        self.boolBtnChoose = self.nilButton;
        self.hasDangerAllow = @"";
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
