//
//  NetworkHandler.h
//  WangYiNews
//
//  Created by JimmyYue on 3/29/15.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"

@interface NetworkHandler : NSObject
{
    LoginViewController *loginVC;
}
+ (void)requestPostWithUrl:(NSString *)urlStr parameters:(NSDictionary *)dic view:(UIViewController *)viewSelf completion:(void (^)(id result))block failure:(void (^)(NSError *error))failure;
+ (void)requestGetWithUrl:(NSString *)urlStr parameters:(NSDictionary *)dic view:(UIViewController *)viewSelf completion:(void (^)(id result))block failure:(void (^)(NSError *error))failure;

@end
