//
//  AddEnterpriseBottomView.h
//  eia
//
//  Created by JimmyYue on 2020/7/4.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddEnterpriseBottomView : UIView

@property (strong, nonatomic) IBOutlet UIButton *switchBtn;

@property (strong, nonatomic) IBOutlet UITextField *contactNameText;

@property (strong, nonatomic) IBOutlet UITextField *phoneText;

@property (strong, nonatomic) IBOutlet UITextField *regionText;

@property (strong, nonatomic) IBOutlet UITextField *addressText;

@property (strong, nonatomic) IBOutlet UIButton *coordinatesBtn;

@property (strong, nonatomic) IBOutlet UITextField *coordinatesText;

@property (strong, nonatomic) IBOutlet UIButton *productionBtn;
- (IBAction)productionBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *noProductionBtn;
- (IBAction)noProductionBtnAction:(id)sender;

@property (strong, nonatomic) NSString *flagMake;
- (void)setAllowAddEnterpriseBottomView;



@end

NS_ASSUME_NONNULL_END
