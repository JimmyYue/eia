//
//  HomeTypeView.h
//  eia
//
//  Created by JimmyYue on 2020/4/28.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkManagementViewController.h"
#import "AddEnterpriseViewController.h"
#import "HomeSearchViewController.h"
#import "PatrolPlanViewController.h"
#import "ChooseIndustryViewController.h"
#import "HomeMapViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeTypeView : UIView

@property (nonatomic, strong) UIView *selfView;
@property (nonatomic, strong) UIViewController *view;

- (IBAction)addEnterpriseAction:(id)sender;

- (IBAction)parkBtnAction:(id)sender;

- (IBAction)learnBtnAction:(id)sender;

- (IBAction)addProductionAction:(id)sender;

- (IBAction)draftBtnAction:(id)sender;

- (IBAction)classificationBtnAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
