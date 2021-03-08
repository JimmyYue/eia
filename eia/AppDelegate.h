//
//  AppDelegate.h
//  eia
//
//  Created by JimmyYue on 2020/4/16.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DWTabBarController.h"
#import "LoginViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UMPush/UMessage.h>             // Push组件
#import <UMCommon/UMCommon.h>
#import <UMCommon/MobClick.h>        // 统计组件
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>


API_AVAILABLE(ios(10.0))
@interface AppDelegate : UIResponder <UIApplicationDelegate, UIApplicationDelegate, UNUserNotificationCenterDelegate, BMKGeneralDelegate>

@property (nonatomic, strong) UIWindow * window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) NSString *deviceToken;
@property (nonatomic, assign) BOOL login;
@property (strong, nonatomic) BMKMapManager* mapManager;
- (void)saveContext;

/// 是否允许转向
@property(nonatomic,assign) BOOL allowRotation;
@property(nonatomic,strong) UIView *statusBar;


@end

