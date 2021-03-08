//
//  SceneDelegate.m
//  eia
//
//  Created by JimmyYue on 2020/4/16.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "SceneDelegate.h"
#import "AppDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

///// 如果属性值为YES，仅允许屏幕向左旋转，否则仅允许竖屏。
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {

    if (self.allowRotation == YES) {
        // 横屏
        return UIInterfaceOrientationMaskLandscape;
    } else {
        // 竖屏
        return (UIInterfaceOrientationMaskPortrait);
    }
}

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        self.window.frame = windowScene.coordinateSpace.bounds;
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
    
    if ([[XYCommon GetUserDefault:@"Login"] isEqualToString:@"yes"]){
        self.window.rootViewController  = [[DWTabBarController alloc]init];
        [self setNetUserEmployee];
    } else {
        LoginViewController *bindingVC = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bindingVC];
        self.window.rootViewController = nav;
    }
    [self.window makeKeyAndVisible];
    
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

- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were pa API_AVAILABLE(ios(13.0))used (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to te API_AVAILABLE(ios(13.0))mporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method  API_AVAILABLE(ios(13.0))to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.

    // Save changes in the application's managed object context when the application transitions to the background.
    if (@available(iOS 10.0, *)) {
        [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
    } else {
        // Fallback on earlier versions
    }
}


@end
