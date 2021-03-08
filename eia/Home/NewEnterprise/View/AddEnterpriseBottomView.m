//
//  AddEnterpriseBottomView.m
//  eia
//
//  Created by JimmyYue on 2020/7/4.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "AddEnterpriseBottomView.h"

@implementation AddEnterpriseBottomView

- (void)setAllowAddEnterpriseBottomView {
    
    UIView *contactNameTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.contactNameText.leftView = contactNameTextView;
    self.contactNameText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *phoneTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.phoneText.leftView = phoneTextView;
    self.phoneText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *addressTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.addressText.leftView = addressTextView;
    self.addressText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *regionTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.regionText.leftView = regionTextView;
    self.regionText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *coordinatesTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.coordinatesText.leftView = coordinatesTextView;
    self.coordinatesText.leftViewMode = UITextFieldViewModeAlways;
    
    self.productionBtn.selected = YES;
    self.productionBtn.backgroundColor =TabbarBlack_S;
    self.flagMake = @"make";

}

- (IBAction)productionBtnAction:(id)sender {
    self.productionBtn.selected = YES;
    self.productionBtn.backgroundColor =TabbarBlack_S;
    self.noProductionBtn.selected = NO;
    self.noProductionBtn.backgroundColor = TableViewLineColor;
    self.flagMake = @"make";
}

- (IBAction)noProductionBtnAction:(id)sender {
    self.noProductionBtn.selected = YES;
    self.noProductionBtn.backgroundColor =TabbarBlack_S;
    self.productionBtn.selected = NO;
    self.productionBtn.backgroundColor = TableViewLineColor;
    self.flagMake = @"notMake";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
