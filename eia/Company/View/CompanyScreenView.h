//
//  CompanyScreenView.h
//  eia
//
//  Created by JimmyYue on 2020/7/3.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeSearchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyScreenView : UIView

@property (nonatomic, strong) UIViewController *view;

@property (strong, nonatomic) IBOutlet UITextField *parkText;
@property (nonatomic, strong) NSString *parkCode;
@property (strong, nonatomic) IBOutlet UIButton *parkChooseBtn;
- (IBAction)parkChooseBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *addStarTimeBtn;
- (IBAction)addStarTimeBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *addEndTimeBtn;
- (IBAction)addEndTimeBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *patrolStarTimeBtn;
- (IBAction)patrolStarTimeBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *patrolEndTimeBtn;
- (IBAction)patrolEndTimeBtnAction:(id)sender;

@property (nonatomic, strong) NSString *engageType;
@property (nonatomic, strong) UIButton *operatingStateBtnChoose;
- (IBAction)operatingStateBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *operatingState1Btn;
@property (strong, nonatomic) IBOutlet UIButton *operatingState2Btn;
@property (strong, nonatomic) IBOutlet UIButton *operatingState3Btn;
@property (strong, nonatomic) IBOutlet UIButton *operatingState4Btn;
@property (strong, nonatomic) IBOutlet UIButton *operatingState5Btn;

@property (nonatomic, strong) NSString *enterpriseType;
@property (nonatomic, strong) UIButton *companyTypeBtnChoose;
- (IBAction)companyTypeBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *companyType1Btn;
@property (strong, nonatomic) IBOutlet UIButton *companyType2Btn;

@property (nonatomic, strong) NSString *resultsType;
@property (nonatomic, strong) UIButton *resultBtnChoose;
- (IBAction)resultBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *result1Btn;
@property (strong, nonatomic) IBOutlet UIButton *result2Btn;
@property (strong, nonatomic) IBOutlet UIButton *result3Btn;

@property (nonatomic, strong) NSString *plantUseType;
@property (nonatomic, strong) UIButton *userTypeBtnChoose;
- (IBAction)userTypeBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *userType1Btn;
@property (strong, nonatomic) IBOutlet UIButton *userType2Btn;

@property (nonatomic, strong) NSString *eiaSortType;
@property (nonatomic, strong) UIButton *eiaTypeBtnChoose;
- (IBAction)eiaTypeBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *eiaType1Btn;
@property (strong, nonatomic) IBOutlet UIButton *eiaType2Btn;
@property (strong, nonatomic) IBOutlet UIButton *eiaType3Btn;

@property (nonatomic, strong) NSString *eiaPaperType;
@property (nonatomic, strong) UIButton *eiaStateBtnChoose;
- (IBAction)eiaStateBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *eiaState1Btn;
@property (strong, nonatomic) IBOutlet UIButton *eiaState2Btn;
@property (strong, nonatomic) IBOutlet UIButton *eiaState3Btn;
@property (strong, nonatomic) IBOutlet UIButton *eiaState4Btn;

@property (nonatomic, strong) NSString *checkPaperType;
@property (nonatomic, strong) UIButton *acceptanceStateBtnChoose;
- (IBAction)acceptanceStateBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *acceptanceState1Btn;
@property (strong, nonatomic) IBOutlet UIButton *acceptanceState2Btn;
@property (strong, nonatomic) IBOutlet UIButton *acceptanceState3Btn;
@property (strong, nonatomic) IBOutlet UIButton *acceptanceState4Btn;

@property (nonatomic, strong) NSString *solidType;
@property (nonatomic, strong) UIButton *wasteDisposalBtnChoose;
- (IBAction)wasteDisposalBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *wasteDisposal1Btn;
@property (strong, nonatomic) IBOutlet UIButton *wasteDisposal2Btn;
@property (strong, nonatomic) IBOutlet UIButton *wasteDisposal3Btn;
@property (strong, nonatomic) IBOutlet UIButton *wasteDisposal4Btn;

@property (nonatomic, strong) NSString *dirtyNatureType;
@property (nonatomic, strong) UIButton *blowdownCategoryBtnChoose;
- (IBAction)blowdownCategoryBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *blowdownCategory1Btn;
@property (strong, nonatomic) IBOutlet UIButton *blowdownCategory2Btn;
@property (strong, nonatomic) IBOutlet UIButton *blowdownCategory3Btn;

@property (nonatomic, strong) NSString *dirtyLicenseType;
@property (nonatomic, strong) UIButton *blowdownCategoryStateBtnChoose;
- (IBAction)blowdownCategoryStateBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *blowdownCategoryState1Btn;
@property (strong, nonatomic) IBOutlet UIButton *blowdownCategoryState2Btn;
@property (strong, nonatomic) IBOutlet UIButton *blowdownCategoryState3Btn;
@property (strong, nonatomic) IBOutlet UIButton *blowdownCategoryState4Btn;

@property (nonatomic, strong) NSString *hasDangerAllow;
@property (nonatomic, strong) UIButton *boolBtnChoose;
- (IBAction)yesOrOnBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *yesBtn;
@property (strong, nonatomic) IBOutlet UIButton *noBtn;

@property (nonatomic, strong) UIButton *nilButton;


@end

NS_ASSUME_NONNULL_END
