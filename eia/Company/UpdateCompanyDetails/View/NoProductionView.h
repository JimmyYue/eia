//
//  NoProductionView.h
//  eia
//
//  Created by JimmyYue on 2020/4/21.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTextView.h"
#import "HomeSearchViewController.h"
#import "ChooseLocationViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoProductionView : UIView

@property (strong, nonatomic) IBOutlet UITextField *parkNameText;
@property (strong, nonatomic) IBOutlet UIButton *parkNameBtn;
- (IBAction)parkNameBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *contactText;

@property (strong, nonatomic) IBOutlet UITextField *phoneText;

@property (strong, nonatomic) IBOutlet UITextField *timeText;

@property (strong, nonatomic) IBOutlet UIButton *timeBtn;
- (IBAction)timeBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *addressSText;

@property (strong, nonatomic) IBOutlet UILabel *registeredAddressLabel;

- (IBAction)userBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *userTypeSegmentedControl;

@property (strong, nonatomic) IBOutlet UITextField *areaText;

@property (strong, nonatomic) IBOutlet UITextField *landlordText;

@property (strong, nonatomic) IBOutlet UITextField *coordinateText;
- (IBAction)coordinateBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *status1Btn;
@property (strong, nonatomic) IBOutlet UIButton *status2Btn;
@property (strong, nonatomic) IBOutlet UIButton *status3Btn;
@property (strong, nonatomic) IBOutlet UIButton *status4Btn;
@property (strong, nonatomic) IBOutlet UIButton *status5Btn;

@property (strong, nonatomic) UIButton *companyStatusChooseBtn;
- (IBAction)companyStatusBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *taxBeginText;

@property (strong, nonatomic) IBOutlet UITextField *taxEndText;

@property (nonatomic, strong) UIViewController *view;

@property(nonatomic, strong) XBTextView *text;

- (void)setAllowNoProductionView:(NSMutableDictionary *)dic;

- (void)setNetDetail:(NSString *)name;

@property(nonatomic, strong) NSString *latitude;
@property(nonatomic, strong) NSString *longitude;
@property(nonatomic, strong) NSString *parkCode;  // 园区code
@property(nonatomic, strong) NSString *enterpriseCode;  // 企业code
@property (nonatomic, strong) NSString *cityName; // 市
@property (nonatomic, strong) NSString *engageType;  // 企业经营状态
@property (nonatomic, strong) NSString *plantUseType; // 厂房使用类型

@end

NS_ASSUME_NONNULL_END
