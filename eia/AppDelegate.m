//
//  AppDelegate.m
//  eia
//
//  Created by JimmyYue on 2020/4/16.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// 如果属性值为YES，仅允许屏幕向左旋转，否则仅允许竖屏。
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {

    if (self.allowRotation == YES) {
        // 横屏
        return UIInterfaceOrientationMaskLandscape;
    } else {
        // 竖屏
        return (UIInterfaceOrientationMaskPortrait);
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //启动更新检查SDK
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:PGYKey];
    //启动基本SDK
    [[PgyManager sharedPgyManager] startManagerWithAppId:PGYKey];
    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
    
    [NSThread sleepForTimeInterval:2.0];
    
    [SVProgressHUD setMinimumDismissTimeInterval:2.5f];
    [SVProgressHUD setBorderWidth:1];
    [SVProgressHUD setBorderColor:TableViewLineColor];
    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(kDeviceWidth / 2, kDeviceHeight / 2)];
    
    //  友盟
    [UMConfigure initWithAppkey:UMKey channel:@"App Store"];
//    [MobClick setScenarioType:E_UM_NORMAL];
    
    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //   type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    } else {
        // Fallback on earlier versions
    }
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
    
    [UMConfigure setLogEnabled:YES];
    
    //  百度地图
    self.mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [self.mapManager start:MapKey generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed !");
    }
    
    if (@available(iOS 13.0, *)) {
        
    } else {
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        if([[XYCommon GetUserDefault:@"Login"] isEqualToString:@"yes"]){
            self.window.rootViewController  = [[DWTabBarController alloc]init];
            [self setNetUserEmployee];
        } else {
            LoginViewController *bindingVC = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bindingVC];
            self.window.rootViewController = nav;
        }
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}

- (void)setNetUserEmployee {
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"userEmployee/current") parameters:@{@"entity":@{}} view:nil completion:^(id result) {
           
           if ([result[@"isSuccess"] intValue] == 1) {
               [XYCommon SetUserDefault:@"Login" byValue:@"yes"];

               [XYCommon SetUserDefault:@"Id" byValue:[NSString stringWithFormat:@"%@", result[@"result"][@"id"]]];
               [XYCommon SetUserDefault:@"OwnerDeptName" byValue:[NSString stringWithFormat:@"%@", result[@"result"][@"ownerDeptName"]]];
               [XYCommon SetUserDefault:@"UserName" byValue:[NSString stringWithFormat:@"%@", result[@"result"][@"userName"]]];
               [XYCommon SetUserDefault:@"UserPhone" byValue:[NSString stringWithFormat:@"%@", result[@"result"][@"userPhone"]]];
               [XYCommon SetUserDefault:@"Avatar" byValue:[NSString stringWithFormat:@"%@", result[@"result"][@"avatar"]]];
           } else {
               [SVProgressHUD showInfoWithStatus:result[@"message"]];
           }

       } failure:^(NSError *error) {
           NSLog(@"%@", error);
       }];
}

- (void)onGetPermissionState:(int)iError {
    if (0 == iError) {
        NSLog(@"授权成功");
    } else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

// 判断百度地图是否鉴权通过
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13) {
           if (![deviceToken isKindOfClass:[NSData class]]) return;
           const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
           NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                                 ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                                 ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                                 ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
          self.deviceToken = hexToken;
       } else {
           NSString *token = [NSString
                          stringWithFormat:@"%@",deviceToken];
           token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
           token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
           token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
           self.deviceToken = token;
       }
    
//    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"deviceToken : %@", self.deviceToken]];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    NSLog(@"DeviceToken获取失败，原因：%@",error);
}

#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. T API_AVAILABLE(ios(10.0))his implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"eia"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
