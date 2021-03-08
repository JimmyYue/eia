//
//  BasicInformationDetailView.m
//  eia
//
//  Created by JimmyYue on 2020/6/17.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "BasicInformationDetailView.h"

@implementation BasicInformationDetailView

- (void)setAllowBasicInformationDetailView:(NSDictionary *)dic {
    if ([[dic allKeys] containsObject:@"enterpriseName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"enterpriseName"]]] == NO) {
        self.enterpriseNameLabel.text = [NSString stringWithFormat:@"%@", dic[@"enterpriseName"]];
    }
    if ([[dic allKeys] containsObject:@"enterpriseTypeName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"enterpriseTypeName"]]] == NO) {
        self.enterpriseTypeNameLabel.text = [NSString stringWithFormat:@"%@", dic[@"enterpriseTypeName"]];
    }
    if ([[dic allKeys] containsObject:@"legalManName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"legalManName"]]] == NO) {
        self.legalManNameLabel.text = [NSString stringWithFormat:@"%@", dic[@"legalManName"]];
    }
    if ([[dic allKeys] containsObject:@"injection"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"injection"]]] == NO) {
        self.injectionLabel.text = [NSString stringWithFormat:@"%@", dic[@"injection"]];
    }
    if ([[dic allKeys] containsObject:@"creditCode"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"creditCode"]]] == NO) {
        self.creditCodeLabel.text = [NSString stringWithFormat:@"%@", dic[@"creditCode"]];
    }
    if ([[dic allKeys] containsObject:@"taxNumber"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"taxNumber"]]] == NO) {
        self.taxNumberLabel.text = [NSString stringWithFormat:@"%@", dic[@"taxNumber"]];
    }
    if ([[dic allKeys] containsObject:@"agencyCode"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"agencyCode"]]] == NO) {
        self.agencyCodeLabel.text = [NSString stringWithFormat:@"%@", dic[@"agencyCode"]];
    }
    if ([[dic allKeys] containsObject:@"registerOrgan"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"registerOrgan"]]] == NO) {
        self.registerOrganLabel.text = [NSString stringWithFormat:@"%@", dic[@"registerOrgan"]];
    }
    if ([[dic allKeys] containsObject:@"qccDivision"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"qccDivision"]]] == NO) {
        self.qccDivisionLabel.text = [NSString stringWithFormat:@"%@", dic[@"qccDivision"]];
    }
    if ([[dic allKeys] containsObject:@"qccRegisterAddress"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"qccRegisterAddress"]]] == NO) {
        self.qccRegisterAddressLabel.text = [NSString stringWithFormat:@"%@", dic[@"qccRegisterAddress"]];
    }
    if ([[dic allKeys] containsObject:@"taxBegin"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"taxBegin"]]] == NO) {
        self.taxLabel.text = [NSString stringWithFormat:@"%@-%@  万元/年", dic[@"taxBegin"], dic[@"taxEnd"]];
    }
    
    if ([[dic allKeys] containsObject:@"contactName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"contactName"]]] == NO) {
        self.contactLabel.text = [NSString stringWithFormat:@"%@ ", dic[@"contactName"]];
    }
    if ([[dic allKeys] containsObject:@"contactPhone"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"contactPhone"]]] == NO) {
        self.contactLabel.text = [NSString stringWithFormat:@"%@  %@", self.contactLabel.text, dic[@"contactPhone"]];
    }
    
    if ([[dic allKeys] containsObject:@"engageTypeName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"engageTypeName"]]] == NO) {
        self.engageTypeNameLabel.text = [NSString stringWithFormat:@"%@", dic[@"engageTypeName"]];
    }
    if ([[dic allKeys] containsObject:@"cpyObjAddress"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"cpyObjAddress"]]] == NO) {
        self.cpyObjAddressLabel.text = [NSString stringWithFormat:@"%@", dic[@"cpyObjAddress"]];
    }
    if ([[dic allKeys] containsObject:@"plantArea"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"plantArea"]]] == NO) {
        self.plantAreaLabel.text = [NSString stringWithFormat:@"租赁  %@㎡", dic[@"plantArea"]];
    }
    if ([[dic allKeys] containsObject:@"landlordName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"landlordName"]]] == NO) {
        self.landlordNameLabel.text = [NSString stringWithFormat:@"%@", dic[@"landlordName"]];
    }
    if ([[dic allKeys] containsObject:@"situation"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"situation"]]] == NO) {
        self.situationLabel.text = [NSString stringWithFormat:@"%@", dic[@"situation"]];
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
