//
//  BasicInformationDetailView.h
//  eia
//
//  Created by JimmyYue on 2020/6/17.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicInformationDetailView : UIView

@property (strong, nonatomic) IBOutlet UILabel *enterpriseNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *enterpriseTypeNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *legalManNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *injectionLabel;

@property (strong, nonatomic) IBOutlet UILabel *creditCodeLabel;

@property (strong, nonatomic) IBOutlet UILabel *taxNumberLabel;

@property (strong, nonatomic) IBOutlet UILabel *agencyCodeLabel;

@property (strong, nonatomic) IBOutlet UILabel *registerOrganLabel;

@property (strong, nonatomic) IBOutlet UILabel *qccDivisionLabel;

@property (strong, nonatomic) IBOutlet UILabel *qccRegisterAddressLabel;

@property (strong, nonatomic) IBOutlet UILabel *taxLabel;

@property (strong, nonatomic) IBOutlet UILabel *contactLabel;

@property (strong, nonatomic) IBOutlet UILabel *engageTypeNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *cpyObjAddressLabel;

@property (strong, nonatomic) IBOutlet UILabel *plantAreaLabel;

@property (strong, nonatomic) IBOutlet UILabel *landlordNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *situationLabel;

- (void)setAllowBasicInformationDetailView:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
