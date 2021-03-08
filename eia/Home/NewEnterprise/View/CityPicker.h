//
//  CityPicker.h
//  KuFangWuYou
//
//  Created by JimmyYue on 2017/6/1.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CityPicker;

@protocol CityPickerDelegate <NSObject>

@optional

- (void)setDic:(CityPicker *)view dic:(NSMutableDictionary *)pickerDic;

- (void)setHidden:(CityPicker *)view;

@end

@protocol CityPickerDelegate;

@interface CityPicker : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic,assign)id<CityPickerDelegate>delegate;

@property (nonatomic, strong) UIViewController *view;

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *arrayProvince;
@property (nonatomic, strong) NSMutableArray *arrayCity;
@property (nonatomic, strong) NSMutableArray *arrayDistrict;
@property (nonatomic, strong) NSMutableArray *arrayStreet;

@property (nonatomic, strong) NSMutableArray *arrayResult;

@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *districtName;
@property (nonatomic, strong) NSString *streetName;

@property (nonatomic, strong) NSString *provinceCode;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *districtCode;
@property (nonatomic, strong) NSString *streetCode;

@property (nonatomic, assign) NSInteger level;

@end
