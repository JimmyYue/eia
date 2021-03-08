//
//  BlowdownCircumstanceView.m
//  eia
//
//  Created by JimmyYue on 2020/6/16.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "BlowdownCircumstanceView.h"

@implementation BlowdownCircumstanceView

- (void)setAllowBlowdownCircumstanceView:(NSDictionary *)dic {
    
    _noiseText = [XBTextView textViewWithPlaceHolder:@""];
    _noiseText.frame = CGRectMake(10, 65, kDeviceWidth - 20, 75);
    _noiseText.maxTextCount = 2000;
    _noiseText.textView.backgroundColor = BackgroundBlack;
    _noiseText.layer.cornerRadius = 8.0f;
    _noiseText.textView.font = [UIFont systemFontOfSize:15];
    _noiseText.textCountLabel.hidden = YES;
    _noiseText.backgroundColor = BackgroundBlack;
    if ([[dic allKeys] containsObject:@"voiceDepict"]) {
        _noiseText.text = [NSString stringWithFormat:@"%@", dic[@"voiceDepict"]];
    }
    [self addSubview:_noiseText];
    
    _noiseHandlingText = [XBTextView textViewWithPlaceHolder:@""];
    _noiseHandlingText.frame = CGRectMake(10, 185, kDeviceWidth - 20, 75);
    _noiseHandlingText.maxTextCount = 2000;
    _noiseHandlingText.textView.backgroundColor = BackgroundBlack;
    _noiseHandlingText.layer.cornerRadius = 8.0f;
    _noiseHandlingText.textView.font = [UIFont systemFontOfSize:15];
    _noiseHandlingText.textCountLabel.hidden = YES;
    _noiseHandlingText.backgroundColor = BackgroundBlack;
    if ([[dic allKeys] containsObject:@"voiceEffect"]) {
        _noiseHandlingText.text = [NSString stringWithFormat:@"%@", dic[@"voiceEffect"]];
    }
    [self addSubview:_noiseHandlingText];
    
    _describeText = [XBTextView textViewWithPlaceHolder:@"危废处置间\n标识标牌"];
    _describeText.frame = CGRectMake(10, 700, kDeviceWidth - 20, 100);
    _describeText.maxTextCount = 2000;
    _describeText.textView.backgroundColor = BackgroundBlack;
    _describeText.layer.cornerRadius = 8.0f;
    _describeText.textView.font = [UIFont systemFontOfSize:15];
    _describeText.textCountLabel.hidden = YES;
    _describeText.backgroundColor = BackgroundBlack;
    if ([[dic allKeys] containsObject:@"situationText"]) {
           _describeText.text = [NSString stringWithFormat:@"%@", dic[@"situationText"]];
    }
    [self addSubview:_describeText];
    
    if ([[dic allKeys] containsObject:@"dosage"]) {
        self.dosageText.text = [NSString stringWithFormat:@"%@", dic[@"dosage"]];
    }
    if ([[dic allKeys] containsObject:@"powerRate"]) {
        self.powerText.text = [NSString stringWithFormat:@"%@", dic[@"powerRate"]];
    }
    
    if ([[dic allKeys] containsObject:@"fuelType"]) {
        self.fuelType = [NSString stringWithFormat:@"%@", dic[@"fuelType"]];
        if ([self.fuelType isEqualToString:@"not"]) {
            self.fuelType1Btn.selected = YES;
            self.fuelTypeChooseBtn = self.fuelType1Btn;
        } else if ([self.fuelType isEqualToString:@"electric"]) {
            self.fuelType2Btn.selected = YES;
            self.fuelTypeChooseBtn = self.fuelType2Btn;
        } else if ([self.fuelType isEqualToString:@"diesel"]) {
            self.fuelType3Btn.selected = YES;
            self.fuelTypeChooseBtn = self.fuelType3Btn;
        } else if ([self.fuelType isEqualToString:@"gas"]) {
            self.fuelType4Btn.selected = YES;
            self.fuelTypeChooseBtn = self.fuelType4Btn;
        }
    }
    
    if ([[dic allKeys] containsObject:@"boilerType"]) {
        self.boilerType = [NSString stringWithFormat:@"%@", dic[@"boilerType"]];
        if ([self.boilerType isEqualToString:@"life"]) {
            self.userType1Btn.selected = YES;
            self.userTypeChooseBtn = self.userType1Btn;
        } else if ([self.boilerType isEqualToString:@"work"]) {
            self.userType2Btn.selected = YES;
            self.userTypeChooseBtn = self.userType2Btn;
        } else if ([self.boilerType isEqualToString:@"heater"]) {
            self.userType3Btn.selected = YES;
            self.userTypeChooseBtn = self.userType3Btn;
        } else if ([self.boilerType isEqualToString:@"bath"]) {
            self.userType4Btn.selected = YES;
            self.userTypeChooseBtn = self.userType4Btn;
        } else if ([self.boilerType isEqualToString:@"drying"]) {
            self.userType5Btn.selected = YES;
            self.userTypeChooseBtn = self.userType5Btn;
        } else if ([self.boilerType isEqualToString:@"cleanse"]) {
            self.userType6Btn.selected = YES;
            self.userTypeChooseBtn = self.userType6Btn;
        }
    }
    
    if ([[dic allKeys] containsObject:@"hasDangerAllow"]) {
        if ([dic[@"hasDangerAllow"] intValue] == 1) {
            self.hasDangerAllow = @"true";
        } else {
            self.hasDangerAllow = @"false";
        }
        
        if ([self.hasDangerAllow isEqualToString:@"true"]) {
            self.yesBtn.selected = YES;
            self.boolBtnChoose = self.yesBtn;
        } else {
            self.noBtn.selected = YES;
            self.boolBtnChoose = self.noBtn;
        }
    }
    
}

- (IBAction)fuelTypeBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.fuelTypeChooseBtn.selected == YES) {
        self.fuelTypeChooseBtn.selected = NO;
    }
    button.selected = YES;
    self.fuelTypeChooseBtn = button;

    if (button.tag == 300) {
           self.fuelType = @"not";
       } else if (button.tag == 301) {
           self.fuelType = @"electric";
       } else if (button.tag == 302) {
           self.fuelType = @"diesel";
       } else if (button.tag == 303) {
           self.fuelType = @"gas";
       }
}

- (IBAction)userTypeBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.userTypeChooseBtn.selected == YES) {
        self.userTypeChooseBtn.selected = NO;
    }
    button.selected = YES;
    self.userTypeChooseBtn = button;

    if (button.tag == 310) {
        self.boilerType = @"life";
    } else if (button.tag == 311) {
        self.boilerType = @"work";
    } else if (button.tag == 312) {
        self.boilerType = @"heater";
    } else if (button.tag == 313) {
        self.boilerType = @"bath";
    } else if (button.tag == 314) {
        self.boilerType = @"drying";
    } else if (button.tag == 315) {
        self.boilerType = @"cleanse";
    }
}

- (IBAction)chooseBtnAction:(id)sender {
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
