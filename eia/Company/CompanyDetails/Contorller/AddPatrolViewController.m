//
//  AddPatrolViewController.m
//  eia
//
//  Created by JimmyYue on 2020/6/23.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "AddPatrolViewController.h"

@interface AddPatrolViewController ()

@end

@implementation AddPatrolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新增巡查";
    self.view.backgroundColor = BackgroundBlack;
    
    self.selectedAssets = [[NSMutableArray alloc] init];
    self.imageCodeArray = [[NSMutableArray alloc] init];
    self.chooseArray = [[NSMutableArray alloc] init];
    
    //  UICollectionView 的使用
    UICollectionViewFlowLayout *flowlayoutS = [[UICollectionViewFlowLayout alloc] init];
    flowlayoutS.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayoutS.itemSize = CGSizeMake((self.view.frame.size.width - 50) / 4, (self.view.frame.size.width - 50) / 4);
    flowlayoutS.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 1, kDeviceWidth, kDeviceHeight - NavRect - StatusRect - 80) collectionViewLayout:flowlayoutS];
    self.photoCollectionView.backgroundColor = [UIColor whiteColor];
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    [self.view addSubview: self.photoCollectionView];
    
    [self.photoCollectionView registerNib:[UINib nibWithNibName:@"PhotographCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PhotographCollectionViewCell"];
    
    UIButton *productBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    productBtn.frame = CGRectMake(15, self.photoCollectionView.frame.origin.y + self.photoCollectionView.frame.size.height + 15, (kDeviceWidth - 40) * 2 / 5, 50);
    [productBtn addTarget:self action:@selector(productBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [productBtn.layer setCornerRadius:8.0];
    [productBtn setTitle:@"生产本次检查单" forState:UIControlStateNormal];
    productBtn.backgroundColor = TabbarBlack_S;
    [productBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    productBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:productBtn];
    
    UIButton *addtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addtBtn.frame = CGRectMake(productBtn.frame.origin.x + productBtn.frame.size.width + 10, self.photoCollectionView.frame.origin.y + self.photoCollectionView.frame.size.height + 15, (kDeviceWidth - 40) * 3 / 5, 50);
    [addtBtn addTarget:self action:@selector(addtBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [addtBtn.layer setCornerRadius:8.0];
    [addtBtn setTitle:@"新增本次巡查" forState:UIControlStateNormal];
    addtBtn.backgroundColor = TabbarBlack_S;
    [addtBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addtBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:addtBtn];
}

- (void)productBtnAction {
    
}

- (void)addtBtnAction {
    if ([IsBlankString isBlankString:self.headerView.purposeText.text] == NO) {
        if ([IsBlankString isBlankString:self.headerView.engageType] == NO) {
            if ([IsBlankString isBlankString:self.headerView.resultsType] == NO) {
                if ([IsBlankString isBlankString:self.headerView.opinionText.text] == NO) {
                    if ([self.headerView.needSign isEqual:@(true)]) {
                        if ([IsBlankString isBlankString:self.imageCode] == NO) {  // 企业签名图片code
                            [self setNet:@{@"etpId":self.EtpId, @"purpose":self.headerView.purposeText.text, @"engageType":self.headerView.engageType, @"resultsType":self.headerView.resultsType, @"needSign":self.headerView.needSign, @"resultsText":self.headerView.opinionText.text, @"followFileList":self.imageCodeArray, @"signatureImg":self.imageCode}];
                        }  else {
                            [SVProgressHUD showInfoWithStatus:@"请上传企业签名!"];
                        }
                    } else {
                        [self setNet:@{@"etpId":self.EtpId, @"purpose":self.headerView.purposeText.text, @"engageType":self.headerView.engageType, @"resultsType":self.headerView.resultsType, @"needSign":self.headerView.needSign, @"resultsText":self.headerView.opinionText.text, @"followFileList":self.imageCodeArray}];
                    }
                } else {
                    [SVProgressHUD showInfoWithStatus:@"请填写本次检查结果说明!"];
                }
            } else {
                [SVProgressHUD showInfoWithStatus:@"请选择巡查意见"];
            }
        } else {
            [SVProgressHUD showInfoWithStatus:@"请选择企业经营状态!"];
        }
    } else {
        [SVProgressHUD showInfoWithStatus:@"请填写巡查目的!"];
    }
}

- (void)setNet:(NSDictionary *)dic {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"提交中...";
        
        [NetworkHandler requestPostWithUrl:API_BASE_URL(@"etpFollow/create") parameters:@{@"entity":dic} view:nil completion:^(id result) {
            
            if ([result[@"isSuccess"] intValue] == 1) {
                self.reloadBlock(self.headerView.statusChooseBtn.titleLabel.text);
                [self.navigationController popViewControllerAnimated:YES];
            }
            [SVProgressHUD showInfoWithStatus:result[@"message"]];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.chooseArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indtifer = @"PhotographCollectionViewCell";
    PhotographCollectionViewCell *cell = [self.photoCollectionView dequeueReusableCellWithReuseIdentifier:indtifer forIndexPath:indexPath];
    
    if (self.chooseArray.count > 0) {
        if (indexPath.row == self.chooseArray.count) {
            cell.chooseBtn.hidden = YES;
            cell.imageViewP.image = IMAGENAMED(@"add_photo");
        } else {
            cell.chooseBtn.hidden = NO;
            [cell.chooseBtn setImage:IMAGENAMED(@"image_close") forState:UIControlStateNormal];
            [cell.imageViewP sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImagePdfVideoFileUrl, self.chooseArray[indexPath.row][@"id"]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
            [cell.chooseBtn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.chooseBtn.tag = indexPath.row + 300;
        }
        
    } else {
        cell.chooseBtn.hidden = YES;
        cell.imageViewP.image = IMAGENAMED(@"add_photo");
    }
   
    return cell;
}

- (void)chooseBtnAction:(UIButton *)button {
    [self.chooseArray removeObjectAtIndex:button.tag - 300];
    [self.imageCodeArray removeObjectAtIndex:button.tag - 300];
    [self.selectedAssets removeObjectAtIndex:button.tag - 300];
    [self.photoCollectionView reloadData];
}

#pragma mark <UICollectionViewDelegate>
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.frame.size.width - 50) / 4, (self.view.frame.size.width - 50) / 4);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.chooseArray.count > 0) {
        if (indexPath.row == self.chooseArray.count - 1) {
           [self setChoooseImage];
        }
    } else {
        [self setChoooseImage];
    }
}

// 要先设置表头大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 630);
    return size;
}
 
// 创建一个继承collectionReusableView的类,用法类比tableViewcell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
       UICollectionReusableView *reusableView = nil;
    
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            
             [collectionView registerNib:[UINib nibWithNibName:@"AddPatrolHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AddPatrolHeaderView"];
            
            self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AddPatrolHeaderView" forIndexPath:indexPath];
            self.headerView.backgroundColor = [UIColor lightTextColor];
            [self.headerView setAllowAddPatrolHeaderView];
            
            [self.headerView.signatureBtn addTarget:self action:@selector(signatureBtnAction) forControlEvents:UIControlEventTouchUpInside];
            
            if ([IsBlankString isBlankString:self.resultsText] == NO) {
                self.headerView.opinionText.text = self.resultsText;
            }
            self.headerView.opinionText.delegate = self;
            
            reusableView = self.headerView;
        } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            // 底部视图
        }
    
        return reusableView;
}

- (void)signatureBtnAction {
    SignatureViewController *signVC = [[SignatureViewController alloc] init];
    [signVC setBlock:^(UIImage * _Nonnull image) {
        self.headerView.signatureImage.image = image;
        NSData *imageData;
        imageData = UIImageJPEGRepresentation(image, 1.0);
        [self setUploadNet:@[imageData] type:@"imageS"];
    }];
    [self.navigationController pushViewController:signVC animated:YES];
}

-(void)xbTextViewShouldEndEditing:(XBTextView *)xbTextView {
    self.resultsText = xbTextView.text;
}

- (void)setChoooseImage {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:100 columnNumber:1 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    //    if (self.maxCountTF.text.integerValue > 1) {
    // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    //    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
    // imagePickerVc.photoWidth = 1000;
    
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
            if ([type isEqualToString:@"image"] || [type isEqualToString:@"imageS"]) {
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

//            NSLog(@"%@", responseDict);
            
            if ([type isEqualToString:@"imageS"]) {
                for (int i = 0; i < [responseDict[@"result"] count]; i++) {
                    self.imageCode = [NSString stringWithFormat:@"%@", responseDict[@"result"][0][@"id"]];
                }
            } else {
                for (int i = 0; i < [responseDict[@"result"] count]; i++) {
                    [self.chooseArray addObject:responseDict[@"result"][i]];
                    [self.imageCodeArray addObject:responseDict[@"result"][i][@"id"]];
                    [self.selectedAssets addObject:arrayUpload[i]];
                }
                [self.photoCollectionView reloadData];
            }
        }
        [SVProgressHUD showInfoWithStatus:responseDict[@"message"]];
        
        return ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n\n --------------- \n\n failure : %@",error);
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
