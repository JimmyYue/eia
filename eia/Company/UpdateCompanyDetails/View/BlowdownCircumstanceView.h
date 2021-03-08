//
//  BlowdownCircumstanceView.h
//  eia
//
//  Created by JimmyYue on 2020/6/16.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlowdownCircumstanceView : UIView<XBTextViewDelegate>

- (void)setAllowBlowdownCircumstanceView:(NSDictionary *)dic;

@property(nonatomic, strong) XBTextView *noiseText;
@property(nonatomic, strong) XBTextView *noiseHandlingText;
@property(nonatomic, strong) XBTextView *describeText;

@property (strong, nonatomic) NSString *fuelType;
@property (strong, nonatomic) IBOutlet UIButton *fuelType1Btn;
@property (strong, nonatomic) IBOutlet UIButton *fuelType2Btn;
@property (strong, nonatomic) IBOutlet UIButton *fuelType3Btn;
@property (strong, nonatomic) IBOutlet UIButton *fuelType4Btn;
@property (strong, nonatomic) UIButton *fuelTypeChooseBtn;
- (IBAction)fuelTypeBtnAction:(id)sender;

@property (strong, nonatomic) NSString *boilerType;
@property (strong, nonatomic) IBOutlet UIButton *userType1Btn;
@property (strong, nonatomic) IBOutlet UIButton *userType2Btn;
@property (strong, nonatomic) IBOutlet UIButton *userType3Btn;
@property (strong, nonatomic) IBOutlet UIButton *userType4Btn;
@property (strong, nonatomic) IBOutlet UIButton *userType5Btn;
@property (strong, nonatomic) IBOutlet UIButton *userType6Btn;
@property (strong, nonatomic) UIButton *userTypeChooseBtn;
- (IBAction)userTypeBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *dosageText;

@property (strong, nonatomic) IBOutlet UITextField *powerText;

@property (strong, nonatomic) NSString *hasDangerAllow;
@property (strong, nonatomic) UIButton *boolBtnChoose;
@property (strong, nonatomic) IBOutlet UIButton *yesBtn;
@property (strong, nonatomic) IBOutlet UIButton *noBtn;
- (IBAction)chooseBtnAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
