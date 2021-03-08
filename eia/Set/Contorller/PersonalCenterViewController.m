//
//  PersonalCenterViewController.m
//  eia
//
//  Created by JimmyYue on 2020/6/11.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "PersonalCenterViewController.h"

@interface PersonalCenterViewController ()

@end

@implementation PersonalCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.hidesBottomBarWhenPushed = NO;
}

- (void)reloadList {
    if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"UserName"]] == NO) {
        self.empNameLabel.text = [XYCommon GetUserDefault:@"UserName"];
    }
    
    if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"UserPhone"]] == NO) {
        self.phoneLabel.text = [XYCommon GetUserDefault:@"UserPhone"];
    }

    if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"OwnerDeptName"]] == NO) {
        self.companyNameLabel.text = [XYCommon GetUserDefault:@"OwnerDeptName"];
    }
    
    if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"Avatar"]] == NO) {
        [self.empImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImagePdfVideoFileUrl, [XYCommon GetUserDefault:@"Avatar"]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadList) name:@"ReloadList" object:nil];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.view.backgroundColor = BackgroundBlack;
    
    [self reloadList];
}


- (IBAction)photoBtnAction:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@ "是否修改您的头像?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setChoooseImage];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)setBtnAction:(id)sender {
    SettingViewController *setVC = [SettingViewController alloc];
    setVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setVC animated:YES];
}

- (IBAction)setPassBtnAction:(id)sender {
    ForgetPassViewController *forgetPassVC = [[ForgetPassViewController alloc] init];
    forgetPassVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:forgetPassVC animated:YES];
}

- (IBAction)exitBtnAction:(id)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"退出登录中...";
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"userEmployee/logout") parameters:@{} view:nil completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            [XYCommon SetUserDefault:@"Request_token" byValue:@""];
            [XYCommon SetUserDefault:@"Secure" byValue:@""];
            
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            loginVC.type = @"net";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView transitionWithView:self.navigationController.view duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    CATransition* transition = [CATransition animation];
                    transition.duration = 0.0f;
                    transition.type = kCATransitionPush;
                    transition.subtype = kCATransitionFromTop;//可以修改从哪个方向过来
                    transition.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];//动画效果
                    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];//添加动画
                    [self.navigationController pushViewController:loginVC animated:NO];
                } completion:nil];
            });
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"message"]];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}



- (void)setChoooseImage {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:1 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    //    if (self.maxCountTF.text.integerValue > 1) {
    // 1.设置目前已经选中的图片数组
//    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    //    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
//     imagePickerVc.photoWidth = 1000;
    
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    imagePickerVc.showSelectBtn = NO;
    
    // 设置竖屏下的裁剪尺寸
    //    NSInteger left = 30;
    //    NSInteger widthHeight = self.view.tz_width - 2 * left;
    //    NSInteger top = (self.view.tz_height - widthHeight) / 2;
    //    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    
    imagePickerVc.isStatusBarDefault = NO;
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        self.photoImage = photos[0];
        
        if (photos.count > 0) {
            NSMutableArray *arrayImage = [[NSMutableArray alloc] init];
            for (UIImage *image in photos) {
                float compressionQuality;
                if ([[[self value:image] substringFromIndex:[self value:image].length - 3] isEqualToString:@"KB"]) {
                    compressionQuality = 1.0;
                } else {
                    if ([[[self value:image] substringToIndex:[self value:image].length - 3] floatValue] > 1 && [[[self value:image] substringToIndex:[self value:image].length - 3] floatValue] <= 2) {
                        compressionQuality = 0.7;
                    } else if ([[[self value:image] substringToIndex:[self value:image].length - 3] floatValue] > 2 &&[[[self value:image] substringToIndex:[self value:image].length - 3] floatValue] <= 4) {
                        compressionQuality = 0.7;
                    } else if ([[[self value:image] substringToIndex:[self value:image].length - 3] floatValue] > 4 &&[[[self value:image] substringToIndex:[self value:image].length - 3] floatValue] <= 8) {
                        compressionQuality = 0.2;
                    } else if ([[[self value:image] substringToIndex:[self value:image].length - 3] floatValue] > 8) {
                        compressionQuality = 0.1;
                    } else {
                        compressionQuality = 1.0;
                    }
                }
                NSData *imageData;
                imageData = UIImageJPEGRepresentation(image, compressionQuality);
                [arrayImage addObject:imageData];
            }
            
            [self setUploadNet:arrayImage type:@"image"];
        }
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


- (NSString *)value:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    docDir = [docDir stringByAppendingString:[NSString stringWithFormat:@"/0021.%.3f.jpg", 1.0]];
    NSLog(@"path = %@",docDir);
    [data writeToFile:docDir atomically:YES];
    return [self data:data value:1.0];
}

- (NSString *)data:(NSData *)data value:(float)value {
    double dataLength = [data length] * 1.0;
//    double orgrionLenght = dataLength;
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (dataLength > 1024) {
        dataLength /= 1024.0;
        index ++;
    }
    NSString *str = [NSString stringWithFormat:@"%.1f%@\n", dataLength, typeArray[index]];
    return str;
}


- (void)setUploadNet:(NSArray *)arrayUpload type:(NSString *)type{  //  上传请求
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"Request_token"]] == NO) {
        [manager.requestSerializer setValue:[XYCommon GetUserDefault:@"Request_token"] forHTTPHeaderField:@"hbgj_pc_user_request_token"];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"上传中...";
    
    [manager POST:API_BASE_URL(@"file/upload") parameters:@{@"file":@"file"} headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        for (int i = 0; i < arrayUpload.count; i++) {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            NSData *imageData = arrayUpload[i];
            NSString *fileName;
            if ([type isEqualToString:@"image"]) {
                fileName=[NSString stringWithFormat:@"%@.jpg",str];
                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"file/jpeg"];
            } else {
                fileName=[NSString stringWithFormat:@"%@.mp4",str];
                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"file/mp4"];
            }
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {

        NSLog(@"\n\n --------------- \n\n progress : %@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];

        NSLog(@"\n\n --------------- \n\n responseObject:%@ \n\n --------------- \n\n ",responseObject);

        NSString *responseStr = [[NSString alloc] initWithData:(NSData *)responseObject  encoding:NSUTF8StringEncoding];

        NSLog(@"\n\n --------------- \n\n success responseStr: %@   \n\n --------------- \n\n",responseStr);

        NSData *jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers
                                                                       error:&err];
        if(err) {
            NSLog(@"json解析失败：%@",err);
            return ;
        }
        if ([[NSString stringWithFormat:@"%@", responseDict[@"isSuccess"]] isEqualToString:@"1"]) {

            NSLog(@"%@", responseDict);
            
            [self setEmpUpdate:[NSString stringWithFormat:@"%@", responseDict[@"result"][0][@"id"]]];

        }
        [SVProgressHUD showInfoWithStatus:responseDict[@"message"]];

        return ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n\n --------------- \n\n failure : %@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)setEmpUpdate:(NSString *)Id {
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"emp/update") parameters:@{@"entity":@{@"id":[XYCommon GetUserDefault:@"Id"], @"avatar":Id}} view:nil completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.empImageView.image = self.photoImage;
         
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"message"]];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
