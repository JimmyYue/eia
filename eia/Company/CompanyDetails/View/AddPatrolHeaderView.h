//
//  AddPatrolHeaderView.h
//  eia
//
//  Created by JimmyYue on 2020/6/23.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddPatrolHeaderView : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UITextField *purposeText;

@property (strong, nonatomic) NSString *engageType;
@property (strong, nonatomic) UIButton *statusChooseBtn;
@property (strong, nonatomic) IBOutlet UIButton *status1Btn;
@property (strong, nonatomic) IBOutlet UIButton *status2Btn;
@property (strong, nonatomic) IBOutlet UIButton *status3Btn;
@property (strong, nonatomic) IBOutlet UIButton *status4Btn;
@property (strong, nonatomic) IBOutlet UIButton *status5Btn;

@property (strong, nonatomic) NSString *resultsType;
@property (strong, nonatomic) UIButton *opinionChooseBtn;
@property (strong, nonatomic) IBOutlet UIButton *perfectBtn;
@property (strong, nonatomic) IBOutlet UIButton *rectificationBtn;
@property (strong, nonatomic) IBOutlet UIButton *riskBtn;

@property (assign, nonatomic) NSNumber *needSign;
@property (strong, nonatomic) IBOutlet UIButton *signatureBtnNeed;

@property (strong, nonatomic) IBOutlet UIImageView *signatureImage;

@property (strong, nonatomic) IBOutlet UIButton *signatureBtn;

@property(nonatomic, strong) XBTextView *opinionText;

- (void)setAllowAddPatrolHeaderView;

@end

NS_ASSUME_NONNULL_END
