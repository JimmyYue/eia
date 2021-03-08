//
//  NewParkViewController.h
//  eia
//
//  Created by JimmyYue on 2020/4/24.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseLocationViewController.h"
#import "InheritanceViewController.h"
#import "CityPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewParkViewController : InheritanceViewController <CityPickerDelegate>

@property (nonatomic, strong) NSString *type;

@property (strong, nonatomic) IBOutlet UITextField *parkNameText;

@property (strong, nonatomic) IBOutlet UITextField *regionText;

@property (strong, nonatomic) IBOutlet UIButton *regionBtn;
- (IBAction)regionBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *firstBtn;
@property (strong, nonatomic) IBOutlet UIButton *secondBtn;
@property (strong, nonatomic) IBOutlet UIButton *thirdBtn;
@property (strong, nonatomic) IBOutlet UIButton *otherBtn;

@property (strong, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addBtnAction:(id)sender;

- (IBAction)btnAction:(id)sender;

@property (nonatomic, strong) CityPicker *cityPicker;
@property (nonatomic, strong) NSString *lotType;  //地块
@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, strong) NSString *provinceName;  // 省
@property (nonatomic, strong) NSString *cityName; // 市
@property (nonatomic, strong) NSString *regionName; // 区
@property (nonatomic, strong) NSString *streetName; // 街道
@property (nonatomic, strong) NSString *provinceCode;  // 省编码
@property (nonatomic, strong) NSString *cityCode; // 市编码
@property (nonatomic, strong) NSString *regionCode; // 区编码
@property (nonatomic, strong) NSString *streetCode; // 街道编码

@property (nonatomic, strong) NSDictionary *detailDic;
@property (nonatomic,copy)void (^block)(NSDictionary *dic);
@end

NS_ASSUME_NONNULL_END
