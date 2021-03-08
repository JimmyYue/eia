//
//  EiaInformationView.m
//  eia
//
//  Created by JimmyYue on 2020/4/22.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "EiaInformationView.h"

@implementation EiaInformationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setAllowEiaInformationView:(NSMutableDictionary *)dic {
    
    UIView *industryNameText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.industryNameText.leftView = industryNameText;
    self.industryNameText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *eiaText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.eiaText.leftView = eiaText;
    self.eiaText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *acceptanceText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.acceptanceText.leftView = acceptanceText;
    self.acceptanceText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *specificationText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.specificationText.leftView = specificationText;
    self.specificationText.leftViewMode = UITextFieldViewModeAlways;

    
    UIView *sewageText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.sewageText.leftView = sewageText;
    self.sewageText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *drainageText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.drainageText.leftView = drainageText;
    self.drainageText.leftViewMode = UITextFieldViewModeAlways;
    
    
    if ([[dic allKeys] containsObject:@"industryName"]) {
        self.industryNameText.text = [NSString stringWithFormat:@"%@", dic[@"industryName"]];
    }
    
    if ([[dic allKeys] containsObject:@"eiaSortType"]) {
        self.eiaSortType = [NSString stringWithFormat:@"%@", dic[@"eiaSortType"]];
        if ([self.eiaSortType isEqualToString:@"reportBook"]) {
            self.eiaType1Btn.selected = YES;
            self.eiaTypeChooseBtn = self.eiaType1Btn;
        } else if ([self.eiaSortType isEqualToString:@"reportTable"]) {
            self.eiaType2Btn.selected = YES;
            self.eiaTypeChooseBtn = self.eiaType2Btn;
        } else if ([self.eiaSortType isEqualToString:@"registerTable"]) {
            self.eiaType3Btn.selected = YES;
            self.eiaTypeChooseBtn = self.eiaType3Btn;
        }
    }
    
    if ([[dic allKeys] containsObject:@"eiaPaperType"]) {
        self.eiaPaperType = [NSString stringWithFormat:@"%@", dic[@"eiaPaperType"]];
        if ([self.eiaPaperType isEqualToString:@"process"]) {
            self.eia1Btn.selected = YES;
            self.eiaChooseBtn = self.eia1Btn;
        } else if ([self.eiaPaperType isEqualToString:@"over"]) {
            self.eia2Btn.selected = YES;
            self.eiaChooseBtn = self.eia2Btn;
        } else if ([self.eiaPaperType isEqualToString:@"notYet"]) {
            self.eia3Btn.selected = YES;
            self.eiaChooseBtn = self.eia3Btn;
        } else if ([self.eiaPaperType isEqualToString:@"notNeed"]) {
            self.eia4Btn.selected = YES;
            self.eiaChooseBtn = self.eia4Btn;
        }
    }
    
     if ([[dic allKeys] containsObject:@"eiaPaperEssay"]) {
         self.eiaText.text = [NSString stringWithFormat:@"%@", dic[@"eiaPaperEssay"]];
     }
    
    if ([[dic allKeys] containsObject:@"checkPaperType"]) {
        self.checkPaperType = [NSString stringWithFormat:@"%@", dic[@"checkPaperType"]];
        if ([self.checkPaperType isEqualToString:@"process"]) {
            self.acceptance1Btn.selected = YES;
            self.acceptanceChooseBtn = self.acceptance1Btn;
        } else if ([self.checkPaperType isEqualToString:@"over"]) {
            self.acceptance2Btn.selected = YES;
            self.acceptanceChooseBtn = self.acceptance2Btn;
        } else if ([self.checkPaperType isEqualToString:@"notYet"]) {
            self.acceptance3Btn.selected = YES;
            self.acceptanceChooseBtn = self.acceptance3Btn;
        } else if ([self.checkPaperType isEqualToString:@"notNeed"]) {
            self.acceptance4Btn.selected = YES;
            self.acceptanceChooseBtn = self.acceptance4Btn;
        }
    }
    
    if ([[dic allKeys] containsObject:@"checkPaperEssay"]) {
        self.acceptanceText.text = [NSString stringWithFormat:@"%@", dic[@"checkPaperEssay"]];
    }
    
    if ([[dic allKeys] containsObject:@"solidType"]) {
           self.solidType = [NSString stringWithFormat:@"%@", dic[@"solidType"]];
           if ([self.solidType isEqualToString:@"process"]) {
               self.specification1Btn.selected = YES;
               self.specificationChooseBtn = self.specification1Btn;
           } else if ([self.solidType isEqualToString:@"over"]) {
               self.specification2Btn.selected = YES;
               self.specificationChooseBtn = self.specification2Btn;
           } else if ([self.solidType isEqualToString:@"notYet"]) {
               self.specification3Btn.selected = YES;
               self.specificationChooseBtn = self.specification3Btn;
           } else if ([self.solidType isEqualToString:@"notNeed"]) {
               self.specification4Btn.selected = YES;
               self.specificationChooseBtn = self.specification4Btn;
           }
       }
       
       if ([[dic allKeys] containsObject:@"solidEssay"]) {
           self.specificationText.text = [NSString stringWithFormat:@"%@", dic[@"solidEssay"]];
       }
    
    if ([[dic allKeys] containsObject:@"dirtyLicenseType"]) {
        self.dirtyLicenseType = [NSString stringWithFormat:@"%@", dic[@"dirtyLicenseType"]];
        if ([self.dirtyLicenseType isEqualToString:@"process"]) {
            self.sewage1Btn.selected = YES;
            self.sewageChooseBtn = self.sewage1Btn;
        } else if ([self.dirtyLicenseType isEqualToString:@"over"]) {
            self.sewage2Btn.selected = YES;
            self.sewageChooseBtn = self.sewage2Btn;
        } else if ([self.dirtyLicenseType isEqualToString:@"notYet"]) {
            self.sewage3Btn.selected = YES;
            self.sewageChooseBtn = self.sewage3Btn;
        } else if ([self.dirtyLicenseType isEqualToString:@"notNeed"]) {
            self.sewage4Btn.selected = YES;
            self.sewageChooseBtn = self.sewage4Btn;
        }
    }
    
    if ([[dic allKeys] containsObject:@"dirtyLicenseEssay"]) {
        self.sewageText.text = [NSString stringWithFormat:@"%@", dic[@"dirtyLicenseEssay"]];
    }
    
    if ([[dic allKeys] containsObject:@"waterLicenseType"]) {
        self.waterLicenseType = [NSString stringWithFormat:@"%@", dic[@"waterLicenseType"]];
        if ([self.waterLicenseType isEqualToString:@"process"]) {
            self.drainage1Btn.selected = YES;
            self.drainageChooseBtn = self.drainage1Btn;
        } else if ([self.waterLicenseType isEqualToString:@"over"]) {
            self.drainage2Btn.selected = YES;
            self.drainageChooseBtn = self.drainage2Btn;
        } else if ([self.waterLicenseType isEqualToString:@"notYet"]) {
            self.drainage3Btn.selected = YES;
            self.drainageChooseBtn = self.drainage3Btn;
        } else if ([self.waterLicenseType isEqualToString:@"notNeed"]) {
            self.drainage4Btn.selected = YES;
            self.drainageChooseBtn = self.drainage4Btn;
        }
    }
    
    if ([[dic allKeys] containsObject:@"waterLicenseEssay"]) {
        self.drainageText.text = [NSString stringWithFormat:@"%@", dic[@"waterLicenseEssay"]];
    }
    
    if ([[dic allKeys] containsObject:@"dirtyNatureType"]) {
        self.dirtyNatureType = [NSString stringWithFormat:@"%@", dic[@"dirtyNatureType"]];
        if ([self.dirtyNatureType isEqualToString:@"register"]) {
            self.dirtyNatureType1Btn.selected = YES;
            self.dirtyNatureTypeBtnBtn = self.dirtyNatureType1Btn;
        } else if ([self.dirtyNatureType isEqualToString:@"focusModes"]) {
            self.dirtyNatureType2Btn.selected = YES;
            self.dirtyNatureTypeBtnBtn = self.dirtyNatureType2Btn;
        } else if ([self.dirtyNatureType isEqualToString:@"simple"]) {
            self.dirtyNatureType3Btn.selected = YES;
            self.dirtyNatureTypeBtnBtn = self.dirtyNatureType3Btn;
        }
    }
    
}

- (IBAction)dirtyNatureTypeBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.dirtyNatureTypeBtnBtn.selected == YES) {
        self.dirtyNatureTypeBtnBtn.selected = NO;
    }
    button.selected = YES;
    self.dirtyNatureTypeBtnBtn = button;
    
    if (button.tag == 300) {
        self.dirtyNatureType = @"register";
    } else if (button.tag == 301) {
        self.dirtyNatureType = @"focusModes";
    } else if (button.tag == 302) {
        self.dirtyNatureType = @"simple";
    }
}

- (IBAction)eiaTypeBtn:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.eiaTypeChooseBtn.selected == YES) {
        self.eiaTypeChooseBtn.selected = NO;
    }
    button.selected = YES;
    self.eiaTypeChooseBtn = button;
    
    if (button.tag == 230) {
        self.eiaSortType = @"reportBook";
    } else if (button.tag == 231) {
        self.eiaSortType = @"reportTable";
    } else if (button.tag == 232) {
        self.eiaSortType = @"registerTable";
    }
}

- (IBAction)eiaBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.eiaChooseBtn.selected == YES) {
        self.eiaChooseBtn.selected = NO;
    }
    button.selected = YES;
    self.eiaChooseBtn = button;
    
    if (button.tag == 240) {
        self.eiaPaperType = @"process";
    } else if (button.tag == 241) {
        self.eiaPaperType = @"over";
    } else if (button.tag == 242) {
        self.eiaPaperType = @"notYet";
    } else if (button.tag == 243) {
        self.eiaPaperType = @"notNeed";
    }
}

- (IBAction)acceptanceBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.acceptanceChooseBtn.selected == YES) {
        self.acceptanceChooseBtn.selected = NO;
    }
    button.selected = YES;
    self.acceptanceChooseBtn = button;
    
    if (button.tag == 250) {
        self.checkPaperType = @"process";
    } else if (button.tag == 251) {
        self.checkPaperType = @"over";
    } else if (button.tag == 252) {
        self.checkPaperType = @"notYet";
    } else if (button.tag == 253) {
        self.checkPaperType = @"notNeed";
    }
}

- (IBAction)specificationBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.specificationChooseBtn.selected == YES) {
        self.specificationChooseBtn.selected = NO;
    }
    button.selected = YES;
    self.specificationChooseBtn = button;
    
    if (button.tag == 260) {
        self.solidType = @"process";
    } else if (button.tag == 261) {
        self.solidType = @"over";
    } else if (button.tag == 262) {
        self.solidType = @"notYet";
    } else if (button.tag == 263) {
        self.solidType = @"notNeed";
    }
}



- (IBAction)sewageBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.sewageChooseBtn.selected == YES) {
        self.sewageChooseBtn.selected = NO;
    }
    button.selected = YES;
    self.sewageChooseBtn = button;
    
    if (button.tag == 280) {
        self.dirtyLicenseType = @"process";
    } else if (button.tag == 281) {
        self.dirtyLicenseType = @"over";
    } else if (button.tag == 282) {
        self.dirtyLicenseType = @"notYet";
    } else if (button.tag == 283) {
        self.dirtyLicenseType = @"notNeed";
    }
}

- (IBAction)drainageBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.drainageChooseBtn.selected == YES) {
        self.drainageChooseBtn.selected = NO;
    }
    button.selected = YES;
    self.drainageChooseBtn = button;
    
    if (button.tag == 290) {
        self.waterLicenseType = @"process";
    } else if (button.tag == 291) {
         self.waterLicenseType = @"over";
    } else if (button.tag == 292) {
        self.waterLicenseType = @"notYet";
    } else if (button.tag == 293) {
        self.waterLicenseType = @"notNeed";
    }
}

//- (IBAction)userTypeBtnAction:(id)sender {
//    UIButton *button = (UIButton *)sender;
//    if (self.userTypeChooseBtn.selected == YES) {
//        self.userTypeChooseBtn.selected = NO;
//    }
//    button.selected = YES;
//    self.userTypeChooseBtn = button;
//
//    if (button.tag == 310) {
//        self.boilerType = @"life";
//    } else if (button.tag == 311) {
//        self.boilerType = @"work";
//    } else if (button.tag == 312) {
//        self.boilerType = @"heater";
//    } else if (button.tag == 313) {
//        self.boilerType = @"bath";
//    } else if (button.tag == 314) {
//        self.boilerType = @"drying";
//    } else if (button.tag == 315) {
//        self.boilerType = @"cleanse";
//    }
//}
//
//- (IBAction)fuelTypeBtnAction:(id)sender {
//    UIButton *button = (UIButton *)sender;
//    if (self.fuelTypeChooseBtn.selected == YES) {
//        self.fuelTypeChooseBtn.selected = NO;
//    }
//    button.selected = YES;
//    self.fuelTypeChooseBtn = button;
//
//    if (button.tag == 300) {
//           self.fuelType = @"not";
//       } else if (button.tag == 301) {
//           self.fuelType = @"electric";
//       } else if (button.tag == 302) {
//           self.fuelType = @"diesel";
//       } else if (button.tag == 303) {
//           self.fuelType = @"gas";
//       }
//}

@end
