//
//  HomeAllowView.h
//  eia
//
//  Created by JimmyYue on 2020/9/25.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJPieChartView.h"
#import "ParkManagementViewController.h"
#import "AddEnterpriseViewController.h"
#import "HomeSearchViewController.h"
#import "PatrolPlanViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeAllowView : UIView<CJPieChartDelegate>

@property (strong, nonatomic) IBOutlet UIView *dataView;

@property (strong, nonatomic) IBOutlet UILabel *focusEditCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *commonEditCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *normalCountLabel;

@property (strong, nonatomic) IBOutlet UIButton *inputtingBtn;

- (IBAction)inputtingBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *parkBtn;

- (IBAction)parkBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *learnBtn;

- (IBAction)learnBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *consultingBtn;

- (IBAction)consultingBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *classificationBtn;

- (IBAction)classificationBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *planBtn;

- (IBAction)planBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *finishLabel;

@property (strong, nonatomic) IBOutlet UILabel *patrolLabel;

@property (strong, nonatomic) CJPieChartView *pieChartViewF;

@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) UIView *view;
- (void)setHomeAllowView;
- (void)setNetHome;

@end

NS_ASSUME_NONNULL_END
