//
//  NoProductionView.m
//  eia
//
//  Created by JimmyYue on 2020/4/21.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "NoProductionView.h"

@implementation NoProductionView

- (void)setAllowNoProductionView:(NSMutableDictionary *)dic {
    
    UIView *parkNameText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.parkNameText.leftView = parkNameText;
    self.parkNameText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *contactText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.contactText.leftView = contactText;
    self.contactText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *phoneText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.phoneText.leftView = phoneText;
    self.phoneText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *timeText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.timeText.leftView = timeText;
    self.timeText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *addressSText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.addressSText.leftView = addressSText;
    self.addressSText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *areaText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.areaText.leftView = areaText;
    self.areaText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *landlordText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.landlordText.leftView = landlordText;
    self.landlordText.leftViewMode = UITextFieldViewModeAlways;
    self.landlordText.enabled = NO;
    self.landlordText.text = @"无需填写";
    self.landlordText.textColor = [UIColor redColor];
    
    UIView *taxBeginText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.taxBeginText.leftView = taxBeginText;
    self.taxBeginText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *taxEndText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.taxEndText.leftView = taxEndText;
    self.taxEndText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *coordinateText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.coordinateText.leftView = coordinateText;
    self.coordinateText.leftViewMode = UITextFieldViewModeAlways;
    
    _text = [XBTextView textViewWithPlaceHolder:@"企业的基本情况描述"];
    _text.frame = CGRectMake(95, 695, kDeviceWidth - 110, 150);
    _text.maxTextCount = 150;
    _text.textView.backgroundColor = BackgroundBlack;
    _text.textView.layer.cornerRadius = 8.0f;
    _text.textView.font = [UIFont systemFontOfSize:15];
    _text.backgroundColor = [UIColor whiteColor];
    [self addSubview:_text];
    
    
    if ([[dic allKeys] containsObject:@"latitude"]) {
        self.latitude = [NSString stringWithFormat:@"%@", dic[@"latitude"]];
    }
    if ([[dic allKeys] containsObject:@"longitude"]) {
        self.longitude = [NSString stringWithFormat:@"%@", dic[@"longitude"]];
        self.coordinateText.text = [NSString stringWithFormat:@"(%@, %@)", self.latitude, self.longitude];
    }
    
    if ([[dic allKeys] containsObject:@"parkCode"]) {
        self.parkCode = [NSString stringWithFormat:@"%@", dic[@"parkCode"]];
    }
    if ([[dic allKeys] containsObject:@"parkName"]) {
        self.parkNameText.text = [NSString stringWithFormat:@"%@", dic[@"parkName"]];
    }
    if ([[dic allKeys] containsObject:@"taxBegin"]) {
        self.taxBeginText.text = [NSString stringWithFormat:@"%@", dic[@"taxBegin"]];
    }
    if ([[dic allKeys] containsObject:@"taxEnd"]) {
        self.taxEndText.text = [NSString stringWithFormat:@"%@", dic[@"taxEnd"]];
    }
    if ([[dic allKeys] containsObject:@"contactName"]) {
        self.contactText.text = [NSString stringWithFormat:@"%@", dic[@"contactName"]];
    }
    if ([[dic allKeys] containsObject:@"contactPhone"]) {
        self.phoneText.text = [NSString stringWithFormat:@"%@", dic[@"contactPhone"]];
    }
    if ([[dic allKeys] containsObject:@"enterDate"]) {
        self.timeText.text = [[NSString stringWithFormat:@"%@", dic[@"enterDate"]] timeToyyyy_MM_dd];
    }
    if ([[dic allKeys] containsObject:@"cpyObjAddress"]) {
        self.addressSText.text = [NSString stringWithFormat:@"%@", dic[@"cpyObjAddress"]];
        self.registeredAddressLabel.text = [NSString stringWithFormat:@"注册地址 : %@", dic[@"cpyObjAddress"]];
        
        if ([self.addressSText.text containsString:@"省"]) {
            NSArray *array = [[NSString stringWithFormat:@"%@", dic[@"cpyObjAddress"]] componentsSeparatedByString:@"省"];
            NSString *str1 = array[1];
            NSArray *array2 = [str1 componentsSeparatedByString:@"市"];
            self.cityName = [NSString stringWithFormat:@"%@市", array2[0]];
        } else {
            NSArray *array = [self.addressSText.text componentsSeparatedByString:@"市"];
            self.cityName = [NSString stringWithFormat:@"%@市", array[0]];
        }
    }
    
    if ([[dic allKeys] containsObject:@"engageType"]) {
        self.engageType = [NSString stringWithFormat:@"%@", dic[@"engageType"]];
        if ([self.engageType isEqualToString:@"normal"]) {
            self.status1Btn.selected = YES;
        } else if ([self.engageType isEqualToString:@"decoration"]) {
            self.status2Btn.selected = YES;
        } else if ([self.engageType isEqualToString:@"planToMove"]) {
            self.status3Btn.selected = YES;
        } else if ([self.engageType isEqualToString:@"outToMove"]) {
            self.status4Btn.selected = YES;
        } else if ([self.engageType isEqualToString:@"onlyList"]) {
            self.status5Btn.selected = YES;
        }
    }
    
    if ([[dic allKeys] containsObject:@"plantUseType"]) {
        self.plantUseType = [NSString stringWithFormat:@"%@", dic[@"plantUseType"]];
        if ([self.plantUseType isEqualToString:@"self"]) {
            NSDictionary *dicU = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
            [self.userTypeSegmentedControl setTitleTextAttributes:dicU forState:UIControlStateSelected];
            
            NSDictionary *dicN = [NSDictionary dictionaryWithObjectsAndKeys:TabbarBlack_S,NSForegroundColorAttributeName,nil];
            [self.userTypeSegmentedControl setTitleTextAttributes:dicN forState:UIControlStateNormal];
            self.userTypeSegmentedControl.selectedSegmentIndex = 0;
        } else {
            NSDictionary *dicU = [NSDictionary dictionaryWithObjectsAndKeys:TabbarBlack_S,NSForegroundColorAttributeName,nil];
            [self.userTypeSegmentedControl setTitleTextAttributes:dicU forState:UIControlStateNormal];
            
            NSDictionary *dicN = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
            [self.userTypeSegmentedControl setTitleTextAttributes:dicN forState:UIControlStateSelected];
            self.userTypeSegmentedControl.selectedSegmentIndex = 1;
            self.landlordText.enabled = YES;
            self.landlordText.textColor = [UIColor blackColor];
        }
    } else {
        
        self.plantUseType = @"self";
        NSDictionary *dicU = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
        [self.userTypeSegmentedControl setTitleTextAttributes:dicU forState:UIControlStateSelected];
        
        NSDictionary *dicN = [NSDictionary dictionaryWithObjectsAndKeys:TabbarBlack_S,NSForegroundColorAttributeName,nil];
        [self.userTypeSegmentedControl setTitleTextAttributes:dicN forState:UIControlStateNormal];
    }
    
    [self.userTypeSegmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    
    if ([[dic allKeys] containsObject:@"plantArea"]) {
        self.areaText.text = [NSString stringWithFormat:@"%@", dic[@"plantArea"]];
    }
    
    if ([[dic allKeys] containsObject:@"landlordName"]) {
        self.landlordText.text = [NSString stringWithFormat:@"%@", dic[@"landlordName"]];
    }
    
    if ([[dic allKeys] containsObject:@"situation"]) {
        self.text.text = [NSString stringWithFormat:@"%@", dic[@"situation"]];
    }
    
}

-(void)segmentAction:(UISegmentedControl *)Seg{

    NSInteger Index = Seg.selectedSegmentIndex;

    NSLog(@"Index %ld", Index);

    switch (Index) {

        case 0:
            self.landlordText.enabled = NO;
            self.landlordText.text = @"无需填写";
            self.landlordText.textColor = [UIColor redColor];
            
            self.plantUseType = @"self";
            break;

        case 1:
            self.landlordText.enabled = YES;
            self.landlordText.text = @"";
            self.landlordText.textColor = [UIColor blackColor];
            self.plantUseType = @"rent";
            break;

        default:
            break;
    }
}

- (IBAction)parkNameBtnAction:(id)sender {
    HomeSearchViewController *homeSearchVC = [[HomeSearchViewController alloc] init];
    [homeSearchVC setBlock:^(NSDictionary * _Nonnull dic) {
        self.parkCode = [NSString stringWithFormat:@"%@", dic[@"id"]];
        self.parkNameText.text = [NSString stringWithFormat:@"%@", dic[@"parkName"]];
    }];
    homeSearchVC.type = @"choosePark";
    [self.view.navigationController pushViewController:homeSearchVC animated:YES];
}

- (IBAction)userBtnAction:(id)sender {
    if ([IsBlankString isBlankString:self.addressSText.text] == NO) {
        self.registeredAddressLabel.text = [NSString stringWithFormat:@"注册地址为 : %@", self.addressSText.text];
    } else {
        [SVProgressHUD showInfoWithStatus:@"请填写企业地址后使用!"];
    }
}

- (IBAction)timeBtnAction:(id)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate * startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        self.timeText.text = date;
    }];
    datepicker.doneButtonColor = TabbarBlack_S;
    datepicker.dateLabelColor = TabbarBlack_S;
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    datepicker.minLimitDate = [NSDate date:dateTime WithFormat:@"yyyy-MM-dd"];
    datepicker.maxLimitDate = [NSDate date:@"2050-01-01" WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
}

- (IBAction)companyStatusBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.companyStatusChooseBtn.selected == YES) {
        self.companyStatusChooseBtn.selected = NO;
    }
    button.selected = YES;
    self.companyStatusChooseBtn = button;
    
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

- (IBAction)coordinateBtnAction:(id)sender {
        if ([IsBlankString isBlankString:self.addressSText.text] == NO) {
            MapViewController *mapVC = [[MapViewController alloc] init];
            mapVC.searchStr = self.addressSText.text;
            mapVC.locationCity = self.cityName;
            [mapVC setBlock:^(NSString * _Nonnull latitude, NSString * _Nonnull longitude) {
                self.latitude = latitude;
                self.longitude = longitude;
                self.coordinateText.text = [NSString stringWithFormat:@"(%@, %@)", latitude, longitude];
            }];
            [self.view.navigationController pushViewController:mapVC animated:YES];
        } else {
            [SVProgressHUD showInfoWithStatus:@"请填写企业地址!"];
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
