//
//  EiaInformationDetailView.m
//  eia
//
//  Created by JimmyYue on 2020/6/18.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "EiaInformationDetailView.h"

@implementation EiaInformationDetailView

- (void)setAllowEiaInformationDetailView:(NSDictionary *)dic {
    
    if ([[dic allKeys] containsObject:@"industryName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"industryName"]]] == NO) {
        self.industryNameLabel.text = [NSString stringWithFormat:@"%@", dic[@"industryName"]];
    }
    if ([[dic allKeys] containsObject:@"eiaSortTypeName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"eiaSortTypeName"]]] == NO) {
        self.eiaSortTypeNameLabel.text = [NSString stringWithFormat:@"%@", dic[@"eiaSortTypeName"]];
    }
    
    if ([[dic allKeys] containsObject:@"eiaPaperTypeName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"eiaPaperTypeName"]]] == NO) {
        self.eiaPaperTypeNameLabel.text = [NSString stringWithFormat:@"%@", dic[@"eiaPaperTypeName"]];
    }
    if ([[dic allKeys] containsObject:@"eiaPaperEssay"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"eiaPaperEssay"]]] == NO) {
        self.eiaPaperTypeNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.eiaPaperTypeNameLabel.text, dic[@"eiaPaperEssay"]];
    }
    
    if ([[dic allKeys] containsObject:@"checkPaperTypeName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"checkPaperTypeName"]]] == NO) {
        self.checkPaperTypeNameLabel.text = [NSString stringWithFormat:@"%@", dic[@"checkPaperTypeName"]];
    }
    if ([[dic allKeys] containsObject:@"checkPaperEssay"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"checkPaperEssay"]]] == NO) {
           self.checkPaperTypeNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.checkPaperTypeNameLabel.text, dic[@"checkPaperEssay"]];
    }
    
    if ([[dic allKeys] containsObject:@"solidTypeName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"solidTypeName"]]] == NO) {
        self.solidTypeNameLabel.text = [NSString stringWithFormat:@"%@", dic[@"solidTypeName"]];
    }
    if ([[dic allKeys] containsObject:@"solidEssay"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"solidEssay"]]] == NO) {
        self.solidTypeNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.solidTypeNameLabel.text, dic[@"solidEssay"]];
    }
    
    if ([[dic allKeys] containsObject:@"dirtyLicenseTypeName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"dirtyLicenseTypeName"]]] == NO) {
        self.dirtyNatureTypeNameLabel.text = [NSString stringWithFormat:@"%@", dic[@"dirtyLicenseTypeName"]];
    }
    if ([[dic allKeys] containsObject:@"dirtyLicenseEssay"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"dirtyLicenseEssay"]]] == NO) {
        self.dirtyNatureTypeNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.dirtyNatureTypeNameLabel.text, dic[@"dirtyLicenseEssay"]];
    }
    
    if ([[dic allKeys] containsObject:@"waterLicenseTypeName"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"waterLicenseTypeName"]]] == NO) {
        self.dirtyLicenseTypeNameLabel.text = [NSString stringWithFormat:@"%@", dic[@"waterLicenseTypeName"]];
    }
    if ([[dic allKeys] containsObject:@"waterLicenseEssay"] && [IsBlankString isBlankString:[NSString stringWithFormat:@"%@", dic[@"waterLicenseEssay"]]] == NO) {
        self.dirtyLicenseTypeNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.dirtyLicenseTypeNameLabel.text, dic[@"waterLicenseEssay"]];
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
