//
//  PersonalCenterViewController.h
//  eia
//
//  Created by JimmyYue on 2020/6/11.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForgetPassViewController.h"
#import "SettingViewController.h"
#import "TZImagePickerController.h"
#import "XFCameraController.h"
#import <Photos/Photos.h>
#import "UIView+Layout.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalCenterViewController : UIViewController<TZImagePickerControllerDelegate>

@property (nonatomic, assign) BOOL isSelectOriginalPhoto;
@property (nonatomic, strong) UIImage *photoImage;

@property (strong, nonatomic) IBOutlet UIImageView *empImageView;
@property (strong, nonatomic) IBOutlet UILabel *empNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;

- (IBAction)exitBtnAction:(id)sender;

- (IBAction)setPassBtnAction:(id)sender;

- (IBAction)setBtnAction:(id)sender;

- (IBAction)photoBtnAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
