//
//  HomeViewController.m
//  eia
//
//  Created by JimmyYue on 2020/4/16.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.hidesBottomBarWhenPushed = NO;
    
    [XYCommon SetUserDefault:@"LoginN" byValue:@"YES"];
    
//    [self.homeAllowView setNetHome];
    
    [self setNetWeather];
    [self setEtpRelationTourPlanTodayDataNet];
    [self setBingtuCountCheckRateNet];
}

- (void)updateMethod:(NSDictionary *)response {
    if (response[@"downloadURL"]) {
        NSString *message = response[@"releaseNote"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"安装" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:response[@"downloadURL"]] options:@{} completionHandler:nil];
                } else {
                    // Fallback on earlier versions
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:response[@"downloadURL"]]];
                }
        }]];
        [self presentViewController:alert animated:YES completion:^{ }];
    } 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
   
    SceneDelegate *appDelegate = _SceneDelegate
    if (@available(iOS 13.0, *)) {
        // iOS 13  弃用keyWindow属性  从所有windowl数组中取
        appDelegate.statusBar = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame] ;
        appDelegate.statusBar.backgroundColor = TabbarBlack_S;
        [[UIApplication sharedApplication].keyWindow addSubview:appDelegate.statusBar];
    } else {
        appDelegate.statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([appDelegate.statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            appDelegate.statusBar.backgroundColor = TabbarBlack_S;
        }
    }
    
    [XYCommon SetUserDefault:@"LoginN" byValue:@"YES"];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.view.backgroundColor = RGBCOLOR(235, 235, 235);
    
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, StatusRect, kDeviceWidth, kDeviceHeight - StatusRect)];
//    self.scrollView.backgroundColor = RGBCOLOR(235, 235, 235);
//    self.scrollView.contentSize = CGSizeMake(0, 840);
//    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.bounces = NO;
//    [self.view addSubview:self.scrollView];
//
//    self.homeAllowView = [[NSBundle mainBundle] loadNibNamed:@"HomeAllowView" owner:nil options:nil][0];
//    self.homeAllowView.frame = CGRectMake(0, 0, kDeviceWidth, 760);
//    self.homeAllowView.view = self.view;
//    self.homeAllowView.controller = self;
//    [self.scrollView addSubview:self.homeAllowView];
//    [self.homeAllowView setHomeAllowView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, StatusRect, kDeviceWidth, kDeviceHeight - StatusRect - self.tabBarController.tabBar.bounds.size.height)];
    self.scrollView.backgroundColor = RGBCOLOR(240, 240, 240);
    self.scrollView.contentSize = CGSizeMake(0, 695);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    self.homeWeatherView = [[NSBundle mainBundle] loadNibNamed:@"HomeWeatherView" owner:nil options:nil][0];
    self.homeWeatherView.frame = CGRectMake(0, 0, kDeviceWidth, 150);
    self.homeWeatherView.backgroundColor = TabbarBlack_S;
    [self.scrollView addSubview:self.homeWeatherView];
    
    self.homePatrolView = [[NSBundle mainBundle] loadNibNamed:@"HomePatrolView" owner:nil options:nil][0];
    self.homePatrolView.frame = CGRectMake(10, self.homeWeatherView.frame.origin.y + self.homeWeatherView.frame.size.height + 15, kDeviceWidth - 20, 255);
    self.homePatrolView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.homePatrolView];
    
    self.homeTypeView = [[NSBundle mainBundle] loadNibNamed:@"HomeTypeView" owner:nil options:nil][0];
    self.homeTypeView.frame = CGRectMake(10, self.homePatrolView.frame.origin.y + self.homePatrolView.frame.size.height + 10, kDeviceWidth - 20, 255);
    self.homeTypeView.backgroundColor = [UIColor whiteColor];
    self.homeTypeView.view = self;
    self.homeTypeView.selfView = self.view;
    [self.scrollView addSubview:self.homeTypeView];
}

- (void)setBingtuCountCheckRateNet {
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.label.text = @"加载中...";

    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"bingtu/countCheckRate") parameters:@{@"entity":@{}} view:self completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            for (int i = 0; i < [result[@"result"][@"bingFenEntityList"] count]; i++) {
                if ([[NSString stringWithFormat:@"%@", result[@"result"][@"bingFenEntityList"][i][@"bingTuType"]] isEqualToString:@"focusEdit"]) {
                    self.homePatrolView.focusEditLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"bingFenEntityList"][i][@"countNumber"]];
                } else if ([[NSString stringWithFormat:@"%@", result[@"result"][@"bingFenEntityList"][i][@"bingTuType"]] isEqualToString:@"commonEdit"]) {
                    self.homePatrolView.commonEditLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"bingFenEntityList"][i][@"countNumber"]];
                } else if ([[NSString stringWithFormat:@"%@", result[@"result"][@"bingFenEntityList"][i][@"bingTuType"]] isEqualToString:@"normal"]) {
                    self.homePatrolView.normalLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][@"bingFenEntityList"][i][@"countNumber"]];
                }
            }
        } else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)setNetWeather {  // 天气
    
    [NetworkHandler requestGetWithUrl:@"http://wthrcdn.etouch.cn/weather_mini?citykey=101020100" parameters:nil view:self completion:^(id result) {
        
        if ([result[@"status"] intValue] == 1000) {
            
            self.homeWeatherView.timeLabel.text = [NSString stringWithFormat:@"%@", result[@"data"][@"forecast"][0][@"date"]];
            
            self.homeWeatherView.temperatureLabel.text = [NSString stringWithFormat:@"%@ ~ %@", result[@"data"][@"forecast"][0][@"low"], result[@"data"][@"forecast"][0][@"high"]];
            
            self.homeWeatherView.nowTemperatureLabel.text = [NSString stringWithFormat:@"%@℃", result[@"data"][@"wendu"]];
            
            NSString *string = [NSString stringWithFormat:@"%@", result[@"data"][@"forecast"][0][@"fengli"]];
            NSRange range = NSMakeRange(9, 2);
            string = [string substringWithRange:range];//截取范围内的字符串
            
            self.homeWeatherView.windLabel.text = [NSString stringWithFormat:@"%@ %@%@", result[@"data"][@"forecast"][0][@"type"], result[@"data"][@"forecast"][0][@"fengxiang"], string];
            
            self.homeWeatherView.adviceLabel.text = [NSString stringWithFormat:@"%@", result[@"data"][@"ganmao"]];
            
        } else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setEtpRelationTourPlanTodayDataNet {

    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"etpRelationTourPlan/todayData") parameters:@{} view:self completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            for (int i = 0; i < [result[@"result"] count]; i++) {
                if ([[NSString stringWithFormat:@"%@", result[@"result"][i][@"tourPlanStatus"]] isEqualToString:@"finish"]) {
                    self.homePatrolView.countNumberLabel.text = [NSString stringWithFormat:@"%@", result[@"result"][i][@"tourPlanStatusCount"]];
                } else if ([[NSString stringWithFormat:@"%@", result[@"result"][i][@"tourPlanStatus"]] isEqualToString:@"patrol"]) {
                     self.homePatrolView.planLabel.text = [NSString stringWithFormat:@"今日计划 : %@", result[@"result"][i][@"tourPlanStatusCount"]];
                }
            }
        } else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
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
