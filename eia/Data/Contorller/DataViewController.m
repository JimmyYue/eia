//
//  DataViewController.m
//  eia
//
//  Created by JimmyYue on 2020/7/2.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

//  这个方法可以抽取到 UIImage 的分类中
- (UIImage *)imageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:TabbarBlack_S] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.tabBarController.tabBar.hidden = NO;
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"数据中心";
    self.view.backgroundColor = BackgroundBlack;
    
}

- (IBAction)data1BtnAction:(id)sender {
    InspectTheProgressViewController *inspectVC = [[InspectTheProgressViewController alloc] init];
    inspectVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:inspectVC animated:YES];
}

- (IBAction)data2BtnAction:(id)sender {
    EiaFormalitiesViewController *eiaVC = [[EiaFormalitiesViewController alloc] init];
    eiaVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:eiaVC animated:YES];
    
}

- (IBAction)data3BtnAction:(id)sender {
    PatrolResultViewController *patrolResultVC = [[PatrolResultViewController alloc] init];
    patrolResultVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:patrolResultVC animated:YES];
}

- (IBAction)data4BtnAction:(id)sender {
    TheParkInViewController *theParkInVC = [[TheParkInViewController alloc] init];
    theParkInVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:theParkInVC animated:YES];
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
