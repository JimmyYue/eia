//
//  CityPicker.m
//  KuFangWuYou
//
//  Created by JimmyYue on 2017/6/1.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "CityPicker.h"

@implementation CityPicker


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.arrayProvince = [[NSMutableArray alloc] init];
        self.arrayCity = [[NSMutableArray alloc] init];
        self.arrayDistrict = [[NSMutableArray alloc] init];
    
        [self setNetAreacode:@"Province" level:@"1"];

    }
    return self;
}


- (void)picker {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissSelectTimeView)];
    [self addGestureRecognizer:tap];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 315, kDeviceWidth, 40)];
    imageView.userInteractionEnabled = YES;
    imageView.backgroundColor = TabbarBlack_S;
    [self addSubview:imageView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 80, 40);
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismissSelectTimeView) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [imageView addSubview:cancelBtn];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(kDeviceWidth - 80, 0, 80, 40);
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(suerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [imageView addSubview:sureButton];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 275, kDeviceWidth, 260)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pickerView];
    [self.pickerView reloadAllComponents];
    
}

//  隐藏三级联动
-(void)dismissSelectTimeView{
    
    if ([self.delegate respondsToSelector:@selector(setHidden:)]) {
        [self.delegate setHidden:self];
    }
}

// 选择器确定button
- (void)suerButtonAction:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(setHidden:)]) {
        [self.delegate setHidden:self];
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.provinceName forKey:@"provinceName"];
    [dic setObject:self.provinceCode forKey:@"provinceCode"];
    [dic setObject:self.cityName forKey:@"cityName"];
    [dic setObject:self.cityCode forKey:@"cityCode"];
    [dic setObject:self.districtName forKey:@"regionName"];
    [dic setObject:self.districtCode forKey:@"regionCode"];
    if ([IsBlankString isBlankString:self.streetCode] == NO) {
        [dic setObject:self.streetName forKey:@"streetName"];
        [dic setObject:self.streetCode forKey:@"streetCode"];
    }
    
    if ([self.delegate respondsToSelector:@selector(setDic:dic:)]) {
        [self.delegate setDic:self dic:dic];
    }
}

//  返回几行
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.level;
}

//  返回指定列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return self.arrayProvince.count;
    } else if (component == 1) {
        return self.arrayCity.count;
    } else if (component == 2) {
        return self.arrayDistrict.count;
    } else {
        return self.arrayStreet.count;
    }
}

//  返回指定列, 行的高度, 就是自定义的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}

//  返回指定的列宽
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    float width;
    if (self.level == 4) {
        width = kDeviceWidth / 5;
         if (component == 3){
            width = kDeviceWidth * 2 / 5;
        }
    } else {
        width = kDeviceWidth / self.level;
    }
    
    return width;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    for(UIView *singleLine in pickerView.subviews) {
        if (singleLine.frame.size.height < 1) {
            singleLine.backgroundColor = ZitiColor;
        }
    }
    
    UILabel* pickerLabel = (UILabel*)view;
    UILabel *pickerLabel1 = (UILabel *)view;
    UILabel *pickerLabel2 = (UILabel *)view;
    UILabel *pickerLabel3 = (UILabel *)view;
    
    float width;
    if (self.level == 4) {
        width = kDeviceWidth / 5;
         if (component == 3){
            width = kDeviceWidth * 2 / 5;
        }
    } else {
        width = kDeviceWidth / self.level;
    }
    
    if (component == 0){
        
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 35)];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:17]];
        
        NSDictionary *dic = [self.arrayProvince objectAtIndex:row];
        NSString *nameStr = dic[@"areaName"];
        pickerLabel.text = nameStr;
        
        return pickerLabel;
        
    } else if (component == 1) {
        
        pickerLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 35)];
        pickerLabel1.textAlignment = NSTextAlignmentCenter;
        [pickerLabel1 setBackgroundColor:[UIColor clearColor]];
        [pickerLabel1 setFont:[UIFont boldSystemFontOfSize:17]];
        
        NSDictionary *dic = [self.arrayCity objectAtIndex:row];
        NSString *nameStr = dic[@"areaName"];
        pickerLabel1.text = nameStr;
        
        return pickerLabel1;
        
    } else if (component == 2) {
        
        pickerLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 35)];
        pickerLabel2.textAlignment = NSTextAlignmentCenter;
        [pickerLabel2 setBackgroundColor:[UIColor clearColor]];
        [pickerLabel2 setFont:[UIFont boldSystemFontOfSize:17]];
        
        NSDictionary *dic = [self.arrayDistrict objectAtIndex:row];
        NSString *nameStr = dic[@"areaName"];
        pickerLabel2.text = nameStr;
        
        return pickerLabel2;
        
    } else {
        
        pickerLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 35)];
        pickerLabel3.textAlignment = NSTextAlignmentCenter;
        [pickerLabel3 setBackgroundColor:[UIColor clearColor]];
        [pickerLabel3 setFont:[UIFont boldSystemFontOfSize:17]];
        
        NSDictionary *dic = [self.arrayStreet objectAtIndex:row];
        NSString *nameStr = dic[@"areaName"];
        pickerLabel3.text = nameStr;
        
        return pickerLabel3;
    }
    return nil;
}


//  被选择的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        self.provinceName = [[self.arrayProvince objectAtIndex:row] objectForKey:@"areaName"];
        self.provinceCode = [NSString stringWithFormat:@"%@", [[self.arrayProvince objectAtIndex:row] objectForKey:@"id"]];
        [self setNetAreacode:self.provinceCode level:@"2"];
    } else if (component == 1) {
        self.cityName = [[self.arrayCity objectAtIndex:row] objectForKey:@"areaName"];
        self.cityCode = [NSString stringWithFormat:@"%@", [[self.arrayCity objectAtIndex:row] objectForKey:@"id"]];
        [self setNetAreacode:self.cityCode level:@"3"];
    } else if (component == 2) {
        self.districtName = [[self.arrayDistrict objectAtIndex:row] objectForKey:@"areaName"];
        self.districtCode = [NSString stringWithFormat:@"%@", [[self.arrayDistrict objectAtIndex:row] objectForKey:@"id"]];
        if (self.level == 4) {
            [self setNetAreacode: self.districtCode level:@"4"];
        }
    } else if (component == 3) {
        self.streetName = [[self.arrayStreet objectAtIndex:row] objectForKey:@"areaName"];
        self.streetCode = [NSString stringWithFormat:@"%@", [[self.arrayStreet objectAtIndex:row] objectForKey:@"id"]];
    }
}

- (void)setNetAreacode:(NSString *)code level:(NSString *)level {
    
    NSDictionary *dic;
    if ([level isEqualToString:@"1"]) {
        dic = @{@"areaType":@"Province"};
    } else {
        dic = @{@"parentId":code};
    }
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"area/query") parameters:@{@"entity":dic} view:self.view completion:^(id result) {
        
        if ([level isEqualToString:@"1"]) {
            self.arrayProvince = result[@"result"][@"data"];
            self.provinceName = [[self.arrayProvince objectAtIndex:0] objectForKey:@"areaName"];
            self.provinceCode = [NSString stringWithFormat:@"%@", [[self.arrayProvince objectAtIndex:0] objectForKey:@"id"]];
            [self picker];
            [self setNetAreacode:self.provinceCode level:@"2"];
        } else if ([level isEqualToString:@"2"]) {
            self.arrayCity = [NSMutableArray array];
            self.arrayCity = result[@"result"][@"data"];
            self.cityName = [[self.arrayCity objectAtIndex:0] objectForKey:@"areaName"];
            self.cityCode = [NSString stringWithFormat:@"%@", [[self.arrayCity objectAtIndex:0] objectForKey:@"id"]];
            [self setNetAreacode:self.cityCode level:@"3"];
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:0 inComponent:1 animated:NO];
        } else if ([level isEqualToString:@"3"]) {
            self.arrayDistrict = [NSMutableArray array];
            self.arrayDistrict = result[@"result"][@"data"];
            self.districtName = [[self.arrayDistrict objectAtIndex:0] objectForKey:@"areaName"];
            self.districtCode = [NSString stringWithFormat:@"%@", [[self.arrayDistrict objectAtIndex:0] objectForKey:@"id"]];
            if (self.level == 4) {
                [self setNetAreacode:self.districtCode level:@"4"];
            }
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:0 inComponent:2 animated:NO];
        } else if ([level isEqualToString:@"4"]) {

            self.arrayStreet = [NSMutableArray array];
            self.arrayStreet = result[@"result"][@"data"];
            self.streetName = [[self.arrayStreet objectAtIndex:0] objectForKey:@"areaName"];
            self.streetCode = [NSString stringWithFormat:@"%@", [[self.arrayStreet objectAtIndex:0] objectForKey:@"id"]];
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:0 inComponent:3 animated:NO];
        } else {
            [SVProgressHUD showInfoWithStatus:[result objectForKey:@"message"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
