//
//  NetworkHandler.m
//  WangYiNews
//

#import "NetworkHandler.h"
#import "AFHTTPSessionManager.h"

@implementation NetworkHandler

+ (void)requestPostWithUrl:(NSString *)urlStr parameters:(NSDictionary *)dic view:(UIViewController *)viewSelf completion:(void (^)(id result))block failure:(void (^)(NSError *error))failure
{
//    NSDate *timeString = [NSDate date];//当前时间
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[timeString timeIntervalSince1970]];
    
    AFHTTPSessionManager *sessionPost = [AFHTTPSessionManager manager];
    sessionPost.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionPost.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionPost.responseSerializer = [AFJSONResponseSerializer serializer];
    [sessionPost.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"Request_token"]] == NO) {
        [sessionPost.requestSerializer setValue:[XYCommon GetUserDefault:@"Request_token"] forHTTPHeaderField:@"hbgj_pc_user_request_token"];
    }
    
    [sessionPost POST:urlStr parameters:dic headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id result = responseObject;
        
        if ([[NSString stringWithFormat:@"%@", result[@"code"]] isEqualToString:@"U1000"] && [[XYCommon GetUserDefault:@"LoginN"] isEqualToString:@"YES"] && viewSelf != nil) {
            
            [XYCommon SetUserDefault:@"LoginN" byValue:@"NO"];
            
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            loginVC.type = @"net";
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView transitionWithView:viewSelf.navigationController.view duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    CATransition* transition = [CATransition animation];
                    transition.duration = 0.0f;
                    transition.type = kCATransitionPush;
                    transition.subtype = kCATransitionFromTop;//可以修改从哪个方向过来
                    transition.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];//动画效果
                    [viewSelf.navigationController.view.layer addAnimation:transition forKey:kCATransition];//添加动画
                    [viewSelf.navigationController pushViewController:loginVC animated:NO];
                } completion:nil];
//            });
        }
        
        if ([urlStr isEqualToString:API_BASE_URL(@"enterprise/update")] && [result[@"isSuccess"] intValue] == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadList" object:nil userInfo:nil];
        }
        block(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"请求失败");
    }];
}

+ (void)requestGetWithUrl:(NSString *)urlStr parameters:(NSDictionary *)dic view:(UIViewController *)viewSelf completion:(void (^)(id result))block failure:(void (^)(NSError *error))failure {
    
    //    NSDate *timeString = [NSDate date];//当前时间
    //    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[timeString timeIntervalSince1970]];
    
    AFHTTPSessionManager *sessionGet = [AFHTTPSessionManager manager];
    sessionGet.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionGet.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionGet.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionGet.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html",@"text/javascript",nil];
    [sessionGet.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"Request_token"]] == NO) {
        [sessionGet.requestSerializer setValue:[XYCommon GetUserDefault:@"Request_token"] forHTTPHeaderField:@"hbgj_pc_user_request_token"];
    }
    
    [sessionGet GET:urlStr parameters:dic headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id result = responseObject;
        
        if ([[NSString stringWithFormat:@"%@", result[@"code"]] isEqualToString:@"U1000"]) {
            
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            loginVC.type = @"net";
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView transitionWithView:viewSelf.navigationController.view duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    CATransition* transition = [CATransition animation];
                    transition.duration = 0.0f;
                    transition.type = kCATransitionPush;
                    transition.subtype = kCATransitionFromTop;//可以修改从哪个方向过来
                    transition.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];//动画效果
                    [viewSelf.navigationController.view.layer addAnimation:transition forKey:kCATransition];//添加动画
                    [viewSelf.navigationController pushViewController:loginVC animated:NO];
                } completion:nil];
            });
        }
        
        block(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(error);
        NSLog(@"请求失败");
    }];
    
}





@end
