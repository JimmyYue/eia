//
//  SignatureViewController.m
//  eia
//
//  Created by JimmyYue on 2020/9/9.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "SignatureViewController.h"

@interface SignatureViewController ()

@end

@implementation SignatureViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    SceneDelegate *appDelegate = _SceneDelegate
    appDelegate.statusBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.title = @"企业签字";
    self.view.backgroundColor = BackgroundBlack;
    
    SceneDelegate *appDelegate = _SceneDelegate
    // 打开横屏开关
    appDelegate.allowRotation = YES;
    // 调用转屏代码
    [self deviceMandatoryLandscapeWithNewOrientation:UIInterfaceOrientationLandscapeRight];
}

- (IBAction)cancelBtnAction:(UIButton *)sender {
    [self blackView];
}

- (void)blackView {
    
    SceneDelegate *appDelegate = _SceneDelegate
    // 关闭横屏仅允许竖屏
    appDelegate.allowRotation = NO;
    // 切换到竖屏
    [self deviceMandatoryLandscapeWithNewOrientation:UIInterfaceOrientationPortrait];
    
    appDelegate.statusBar.hidden = NO;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clearAction:(UIButton *)sender {
    [self.drawView clear];
}

- (IBAction)sureBtnAction:(id)sender {
    UIImage *image = [self imageWithUIView:self.drawView];
    self.block(image);
    [self blackView];
}

- (UIImage*)imageWithUIView:(UIView*) view {
    
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tImage;
}

/// 输入要强制转屏的方向
/// @param interfaceOrientation 转屏的方向
- (void)deviceMandatoryLandscapeWithNewOrientation:(UIInterfaceOrientation)interfaceOrientation {

    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    // 将输入的转屏方向（枚举）转换成Int类型
    int orientation = (int)interfaceOrientation;
    // 对象包装
    NSNumber *orientationTarget = [NSNumber numberWithInt:orientation];
    // 实现横竖屏旋转
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
