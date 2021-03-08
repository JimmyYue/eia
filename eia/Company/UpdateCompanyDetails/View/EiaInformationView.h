//
//  EiaInformationView.h
//  eia
//
//  Created by JimmyYue on 2020/4/22.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EiaInformationView : UIView

@property (strong, nonatomic) IBOutlet UITextField *industryNameText;
@property (strong, nonatomic) IBOutlet UIButton *chooseClassBtn;

@property (strong, nonatomic) UIButton *eiaTypeChooseBtn;
@property (strong, nonatomic) IBOutlet UIButton *eiaType1Btn;
@property (strong, nonatomic) IBOutlet UIButton *eiaType2Btn;
@property (strong, nonatomic) IBOutlet UIButton *eiaType3Btn;
- (IBAction)eiaTypeBtn:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *eia1Btn;  // 环评
@property (strong, nonatomic) IBOutlet UIButton *eia2Btn;
@property (strong, nonatomic) IBOutlet UIButton *eia3Btn;
@property (strong, nonatomic) IBOutlet UIButton *eia4Btn;
@property (strong, nonatomic) UIButton *eiaChooseBtn;
- (IBAction)eiaBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *eiaText;

@property (strong, nonatomic) IBOutlet UIButton *acceptance1Btn;  // 验收
@property (strong, nonatomic) IBOutlet UIButton *acceptance2Btn;
@property (strong, nonatomic) IBOutlet UIButton *acceptance3Btn;
@property (strong, nonatomic) IBOutlet UIButton *acceptance4Btn;
@property (strong, nonatomic) UIButton *acceptanceChooseBtn;
- (IBAction)acceptanceBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *acceptanceText;

@property (strong, nonatomic) IBOutlet UIButton *specification1Btn; // 危废/固废
@property (strong, nonatomic) IBOutlet UIButton *specification2Btn;
@property (strong, nonatomic) IBOutlet UIButton *specification3Btn;
@property (strong, nonatomic) IBOutlet UIButton *specification4Btn;
@property (strong, nonatomic) UIButton *specificationChooseBtn;
- (IBAction)specificationBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *specificationText;

@property (strong, nonatomic) IBOutlet UIButton *sewage1Btn;  // 排污
@property (strong, nonatomic) IBOutlet UIButton *sewage2Btn;
@property (strong, nonatomic) IBOutlet UIButton *sewage3Btn;
@property (strong, nonatomic) IBOutlet UIButton *sewage4Btn;
@property (strong, nonatomic) UIButton *sewageChooseBtn;
- (IBAction)sewageBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *sewageText;

@property (strong, nonatomic) IBOutlet UIButton *drainage1Btn;  // 排水
@property (strong, nonatomic) IBOutlet UIButton *drainage2Btn;
@property (strong, nonatomic) IBOutlet UIButton *drainage3Btn;
@property (strong, nonatomic) IBOutlet UIButton *drainage4Btn;
@property (strong, nonatomic) UIButton *drainageChooseBtn;
- (IBAction)drainageBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *drainageText;

@property (strong, nonatomic) IBOutlet UIButton *dirtyNatureType1Btn;
@property (strong, nonatomic) IBOutlet UIButton *dirtyNatureType2Btn;
@property (strong, nonatomic) IBOutlet UIButton *dirtyNatureType3Btn;
@property (strong, nonatomic) UIButton *dirtyNatureTypeBtnBtn;
- (IBAction)dirtyNatureTypeBtnAction:(id)sender;



- (void)setAllowEiaInformationView:(NSMutableDictionary *)dic;

@property (nonatomic, strong) NSString *eiaSortType; // 类别
@property (nonatomic, strong) NSString *eiaPaperType;  // 环评批文
@property (nonatomic, strong) NSString *checkPaperType;  // 验收批文
@property (nonatomic, strong) NSString *solidType;  // 危废/固废
@property (nonatomic, strong) NSString *dirtyLicenseType;  // 排污许可证
@property (nonatomic, strong) NSString *waterLicenseType;  // 排水许可证
@property (nonatomic, strong) NSString *dirtyNatureType;  // 排污性质

@end

NS_ASSUME_NONNULL_END
