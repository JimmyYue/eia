//
//  CommpanySearchViewController.m
//  eia
//
//  Created by JimmyYue on 2020/7/3.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "CommpanySearchViewController.h"

@interface CommpanySearchViewController ()

@end

@implementation CommpanySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"筛选条件";
    self.view.backgroundColor = BackgroundBlack;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 1, kDeviceWidth - 10, kDeviceHeight - NavRect - StatusRect - 90)];
    scrollView.backgroundColor = BackgroundBlack;
    scrollView.contentSize = CGSizeMake(0, 975);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    self.companyScreenView = [[NSBundle mainBundle] loadNibNamed:@"CompanyScreenView" owner:nil options:nil][0];
    self.companyScreenView.frame = CGRectMake(0, 0, kDeviceWidth - 10, 975);
    self.companyScreenView.backgroundColor = [UIColor whiteColor];
    self.companyScreenView.view = self;
    [scrollView addSubview:self.companyScreenView];
    
    UIView *parkTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.companyScreenView.parkText.leftView = parkTextView;
    self.companyScreenView.parkText.leftViewMode = UITextFieldViewModeAlways;
    
    if ([[self.dicSearch allKeys] containsObject:@"parkCode"]) {
        self.companyScreenView.parkText.text = [NSString stringWithFormat:@"%@", self.dicSearch[@"parkName"]];
        self.companyScreenView.parkCode = [NSString stringWithFormat:@"%@", self.dicSearch[@"parkCode"]];
    }
    
    if ([[self.dicSearch allKeys] containsObject:@"createTimeStart"]) {
        [self.companyScreenView.addStarTimeBtn setTitle:[NSString stringWithFormat:@"%@", self.dicSearch[@"createTimeStart"]] forState:UIControlStateNormal];
    }
    
    if ([[self.dicSearch allKeys] containsObject:@"createTimeEnd"]) {
        [self.companyScreenView.addEndTimeBtn setTitle:[NSString stringWithFormat:@"%@", self.dicSearch[@"createTimeEnd"]] forState:UIControlStateNormal];
    }
    
    if ([[self.dicSearch allKeys] containsObject:@"followTimeStart"]) {
        [self.companyScreenView.patrolStarTimeBtn setTitle:[NSString stringWithFormat:@"%@", self.dicSearch[@"followTimeStart"]] forState:UIControlStateNormal];
    }
    
    if ([[self.dicSearch allKeys] containsObject:@"followTimeEnd"]) {
        [self.companyScreenView.patrolEndTimeBtn setTitle:[NSString stringWithFormat:@"%@", self.dicSearch[@"followTimeEnd"]] forState:UIControlStateNormal];
    }
    
    if ([[self.dicSearch allKeys] containsObject:@"engageType"]) {
        self.companyScreenView.engageType = self.dicSearch[@"engageType"];
        if ([self.dicSearch[@"engageType"] isEqualToString:@"normal"]) {
            self.companyScreenView.operatingState1Btn.selected = YES;
        } else if ([self.dicSearch[@"engageType"] isEqualToString:@"decoration"]) {
            self.companyScreenView.operatingState2Btn.selected = YES;
        } else if ([self.dicSearch[@"engageType"] isEqualToString:@"onlyList"]) {
            self.companyScreenView.operatingState3Btn.selected = YES;
        } else if ([self.dicSearch[@"engageType"] isEqualToString:@"planToMove"]) {
            self.companyScreenView.operatingState4Btn.selected = YES;
        } else if ([self.dicSearch[@"engageType"] isEqualToString:@"outToMove"]) {
            self.companyScreenView.operatingState5Btn.selected = YES;
        }
    }
    
    if ([[self.dicSearch allKeys] containsObject:@"enterpriseType"]) {
        self.companyScreenView.enterpriseType = self.dicSearch[@"enterpriseType"];
        if ([self.dicSearch[@"enterpriseType"] isEqualToString:@"produce"]) {
            self.companyScreenView.companyType1Btn.selected = YES;
        } else if ([self.dicSearch[@"enterpriseType"] isEqualToString:@"produceNot"]) {
            self.companyScreenView.companyType2Btn.selected = YES;
        }
    }
        
    if ([[self.dicSearch allKeys] containsObject:@"resultsType"]) {
        self.companyScreenView.resultsType = self.dicSearch[@"resultsType"];
        if ([self.dicSearch[@"resultsType"] isEqualToString:@"normal"]) {
            self.companyScreenView.result1Btn.selected = YES;
        } else if ([self.dicSearch[@"resultsType"] isEqualToString:@"commonEdit"]) {
            self.companyScreenView.result2Btn.selected = YES;
        } else if ([self.dicSearch[@"resultsType"] isEqualToString:@"focusEdit"]) {
            self.companyScreenView.result3Btn.selected = YES;
        }
    }
    
    if ([[self.dicSearch allKeys] containsObject:@"plantUseType"]) {
        self.companyScreenView.plantUseType = self.dicSearch[@"plantUseType"];
        if ([self.dicSearch[@"plantUseType"] isEqualToString:@"self"]) {
            self.companyScreenView.userType1Btn.selected = YES;
        } else if ([self.dicSearch[@"plantUseType"] isEqualToString:@"rent"]) {
            self.companyScreenView.userType2Btn.selected = YES;
        } 
    }

    if ([[self.dicSearch allKeys] containsObject:@"eiaSortType"]) {
        self.companyScreenView.eiaSortType = self.dicSearch[@"eiaSortType"];
        if ([self.dicSearch[@"eiaSortType"] isEqualToString:@"reportBook"]) {
            self.companyScreenView.eiaType1Btn.selected = YES;
        } else if ([self.dicSearch[@"eiaSortType"] isEqualToString:@"reportTable"]) {
            self.companyScreenView.eiaType2Btn.selected = YES;
        } else if ([self.dicSearch[@"eiaSortType"] isEqualToString:@"registerTable"]) {
            self.companyScreenView.eiaType3Btn.selected = YES;
        }
    }
    
    if ([[self.dicSearch allKeys] containsObject:@"eiaPaperType"]) {
        self.companyScreenView.eiaPaperType = self.dicSearch[@"eiaPaperType"];
        if ([self.dicSearch[@"eiaPaperType"] isEqualToString:@"process"]) {
            self.companyScreenView.eiaState1Btn.selected = YES;
        } else if ([self.dicSearch[@"eiaPaperType"] isEqualToString:@"over"]) {
            self.companyScreenView.eiaState2Btn.selected = YES;
        } else if ([self.dicSearch[@"eiaPaperType"] isEqualToString:@"notYet"]) {
            self.companyScreenView.eiaState3Btn.selected = YES;
        } else if ([self.dicSearch[@"eiaPaperType"] isEqualToString:@"notNeed"]) {
            self.companyScreenView.eiaState4Btn.selected = YES;
        }
    }
    
    if ([[self.dicSearch allKeys] containsObject:@"checkPaperType"]) {
        self.companyScreenView.checkPaperType = self.dicSearch[@"checkPaperType"];
        if ([self.dicSearch[@"checkPaperType"] isEqualToString:@"process"]) {
            self.companyScreenView.acceptanceState1Btn.selected = YES;
        } else if ([self.dicSearch[@"checkPaperType"] isEqualToString:@"over"]) {
            self.companyScreenView.acceptanceState2Btn.selected = YES;
        } else if ([self.dicSearch[@"checkPaperType"] isEqualToString:@"notYet"]) {
            self.companyScreenView.acceptanceState3Btn.selected = YES;
        } else if ([self.dicSearch[@"checkPaperType"] isEqualToString:@"notNeed"]) {
            self.companyScreenView.acceptanceState4Btn.selected = YES;
        }
    }
    
    if ([[self.dicSearch allKeys] containsObject:@"solidType"]) {
        self.companyScreenView.solidType = self.dicSearch[@"solidType"];
        if ([self.dicSearch[@"solidType"] isEqualToString:@"process"]) {
            self.companyScreenView.wasteDisposal1Btn.selected = YES;
        } else if ([self.dicSearch[@"solidType"] isEqualToString:@"over"]) {
            self.companyScreenView.wasteDisposal2Btn.selected = YES;
        } else if ([self.dicSearch[@"solidType"] isEqualToString:@"notYet"]) {
            self.companyScreenView.wasteDisposal3Btn.selected = YES;
        } else if ([self.dicSearch[@"solidType"] isEqualToString:@"notNeed"]) {
            self.companyScreenView.wasteDisposal4Btn.selected = YES;
        }
    }
    
    if ([[self.dicSearch allKeys] containsObject:@"dirtyNatureType"]) {
        self.companyScreenView.dirtyNatureType = self.dicSearch[@"dirtyNatureType"];
        if ([self.dicSearch[@"dirtyNatureType"] isEqualToString:@"register"]) {
            self.companyScreenView.blowdownCategory1Btn.selected = YES;
        } else if ([self.dicSearch[@"dirtyNatureType"] isEqualToString:@"focusModes"]) {
            self.companyScreenView.blowdownCategory2Btn.selected = YES;
        } else if ([self.dicSearch[@"dirtyNatureType"] isEqualToString:@"simple"]) {
            self.companyScreenView.blowdownCategory3Btn.selected = YES;
        }
    }
    
    if ([[self.dicSearch allKeys] containsObject:@"dirtyLicenseType"]) {
           self.companyScreenView.dirtyLicenseType = self.dicSearch[@"dirtyLicenseType"];
           if ([self.dicSearch[@"dirtyLicenseType"] isEqualToString:@"process"]) {
               self.companyScreenView.blowdownCategoryState1Btn.selected = YES;
           } else if ([self.dicSearch[@"dirtyLicenseType"] isEqualToString:@"over"]) {
               self.companyScreenView.blowdownCategoryState2Btn.selected = YES;
           } else if ([self.dicSearch[@"dirtyLicenseType"] isEqualToString:@"notYet"]) {
               self.companyScreenView.blowdownCategoryState3Btn.selected = YES;
           } else if ([self.dicSearch[@"dirtyLicenseType"] isEqualToString:@"notNeed"]) {
               self.companyScreenView.blowdownCategoryState4Btn.selected = YES;
           }
       }
    
    
    if ([[self.dicSearch allKeys] containsObject:@"hasDangerAllow"]) {
        if ([self.dicSearch[@"hasDangerAllow"] intValue] == 1) {
            self.companyScreenView.hasDangerAllow = @"true";
        } else {
            self.companyScreenView.hasDangerAllow = @"false";
        }
        if ([self.companyScreenView.hasDangerAllow isEqualToString:@"true"]) {
            self.companyScreenView.yesBtn.selected = YES;
        } else if ([self.companyScreenView.hasDangerAllow isEqualToString:@"false"]) {
            self.companyScreenView.noBtn.selected = YES;
        }
    }
    
//    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
//    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
//    [self.companyScreenView.addEndTimeBtn setTitle:dateTime forState:UIControlStateNormal];
//    [self.companyScreenView.patrolEndTimeBtn setTitle:dateTime forState:UIControlStateNormal];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(15, scrollView.frame.origin.y + scrollView.frame.size.height + 20, (kDeviceWidth - 40) * 2 / 5, 50);
    [clearBtn addTarget:self action:@selector(clearBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn.layer setCornerRadius:8.0];
    [clearBtn setTitle:@"清除条件" forState:UIControlStateNormal];
    clearBtn.backgroundColor = ZitiColor;
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:clearBtn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(clearBtn.frame.origin.x + clearBtn.frame.size.width + 10, scrollView.frame.origin.y + scrollView.frame.size.height + 20, (kDeviceWidth - 40) * 3 / 5, 50);
    [searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn.layer setCornerRadius:8.0];
    [searchBtn setTitle:@"按条件查找" forState:UIControlStateNormal];
    searchBtn.backgroundColor = TabbarBlack_S;
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:searchBtn];
}

- (void)clearBtnAction {
    self.companyScreenView.parkCode = @"";
    self.companyScreenView.addStarTimeBtn.titleLabel.text = @"";
    self.companyScreenView.addEndTimeBtn.titleLabel.text = @"";
    self.companyScreenView.patrolStarTimeBtn.titleLabel.text = @"";
    self.companyScreenView.patrolEndTimeBtn.titleLabel.text = @"";
    self.companyScreenView.engageType = @"";
    self.companyScreenView.enterpriseType = @"";
    self.companyScreenView.resultsType = @"";
    self.companyScreenView.plantUseType = @"";
    self.companyScreenView.eiaSortType = @"";
    self.companyScreenView.eiaPaperType = @"";
    self.companyScreenView.checkPaperType = @"";
    self.companyScreenView.solidType = @"";
    self.companyScreenView.dirtyNatureType = @"";
    self.companyScreenView.dirtyLicenseType = @"";
    self.companyScreenView.hasDangerAllow = @"";

    self.companyScreenView.parkText.text = @"";
    self.companyScreenView.operatingStateBtnChoose.selected = NO;
    self.companyScreenView.companyTypeBtnChoose.selected = NO;
    self.companyScreenView.resultBtnChoose.selected = NO;
    self.companyScreenView.userTypeBtnChoose.selected = NO;
    self.companyScreenView.eiaTypeBtnChoose.selected = NO;
    self.companyScreenView.eiaStateBtnChoose.selected = NO;
    self.companyScreenView.acceptanceStateBtnChoose.selected = NO;
    self.companyScreenView.wasteDisposalBtnChoose.selected = NO;
    self.companyScreenView.blowdownCategoryBtnChoose.selected = NO;
    self.companyScreenView.blowdownCategoryStateBtnChoose.selected = NO;
    self.companyScreenView.boolBtnChoose.selected = NO;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    self.block(dic);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBtnAction {
    
    NSMutableDictionary *dicP = [[NSMutableDictionary alloc] init];
    
    if ([IsBlankString isBlankString:self.companyScreenView.parkCode] == NO) {
        [dicP setObject:self.companyScreenView.parkCode forKey:@"parkCode"];
        [dicP setObject:self.companyScreenView.parkText.text forKey:@"parkName"];
    }
    if (![self.companyScreenView.addStarTimeBtn.titleLabel.text isEqualToString:@"请选择日期"]) {
         [dicP setObject:self.companyScreenView.addStarTimeBtn.titleLabel.text forKey:@"createTimeStart"];
    }
    if (![self.companyScreenView.addEndTimeBtn.titleLabel.text isEqualToString:@"至今"]) {
         [dicP setObject:self.companyScreenView.addEndTimeBtn.titleLabel.text forKey:@"createTimeEnd"];
    }
    if (![self.companyScreenView.patrolStarTimeBtn.titleLabel.text isEqualToString:@"请选择日期"]) {
         [dicP setObject:self.companyScreenView.patrolStarTimeBtn.titleLabel.text forKey:@"followTimeStart"];
    }
    if (![self.companyScreenView.patrolEndTimeBtn.titleLabel.text isEqualToString:@"当天"]) {
         [dicP setObject:self.companyScreenView.patrolEndTimeBtn.titleLabel.text forKey:@"followTimeEnd"];
    }
    
    if ([IsBlankString isBlankString:self.companyScreenView.engageType] == NO) {
        [dicP setObject:self.companyScreenView.engageType forKey:@"engageType"];
    }
    if ([IsBlankString isBlankString:self.companyScreenView.enterpriseType] == NO) {
        [dicP setObject:self.companyScreenView.enterpriseType forKey:@"enterpriseType"];
    }
    if ([IsBlankString isBlankString:self.companyScreenView.resultsType] == NO) {
        [dicP setObject:self.companyScreenView.resultsType forKey:@"resultsType"];
    }
    if ([IsBlankString isBlankString:self.companyScreenView.plantUseType] == NO) {
        [dicP setObject:self.companyScreenView.plantUseType forKey:@"plantUseType"];
    }
    if ([IsBlankString isBlankString:self.companyScreenView.eiaSortType] == NO) {
        [dicP setObject:self.companyScreenView.eiaSortType forKey:@"eiaSortType"];
    }
    if ([IsBlankString isBlankString:self.companyScreenView.eiaPaperType] == NO) {
        [dicP setObject:self.companyScreenView.eiaPaperType forKey:@"eiaPaperType"];
    }
    if ([IsBlankString isBlankString:self.companyScreenView.checkPaperType] == NO) {
        [dicP setObject:self.companyScreenView.checkPaperType forKey:@"checkPaperType"];
    }
    if ([IsBlankString isBlankString:self.companyScreenView.dirtyNatureType] == NO) {
           [dicP setObject:self.companyScreenView.dirtyNatureType forKey:@"dirtyNatureType"];
    }
    if ([IsBlankString isBlankString:self.companyScreenView.solidType] == NO) {
        [dicP setObject:self.companyScreenView.solidType forKey:@"solidType"];
    }
    if ([IsBlankString isBlankString:self.companyScreenView.dirtyLicenseType] == NO) {
        [dicP setObject:self.companyScreenView.dirtyLicenseType forKey:@"dirtyLicenseType"];
    }
    if ([IsBlankString isBlankString:self.companyScreenView.hasDangerAllow] == NO) {
        if ([self.companyScreenView.hasDangerAllow isEqualToString:@"true"]) {
            [dicP setObject:@(true)forKey:@"hasDangerAllow"];
        } else {
            [dicP setObject:@(false)forKey:@"hasDangerAllow"];
        }
    }
    
    if (dicP.count > 0) {
        self.block(dicP);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
