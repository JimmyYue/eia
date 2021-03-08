//
//  UpdateImageViewController.m
//  eia
//
//  Created by JimmyYue on 2020/6/23.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "UpdateImageViewController.h"

@interface UpdateImageViewController ()

@end

@implementation UpdateImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图片信息";
    self.view.backgroundColor = BackgroundBlack;
    
    self.titleArray = @[@"营业执照类", @"环评", @"验收", @"应急预案", @"排污 (水) 许可证", @"危废车间照片", @"生产工艺及流程", @"其他现场照片"];
    
    self.licenseFileList = [[NSMutableArray alloc] init];
    self.eiaFileList = [[NSMutableArray alloc] init];
    self.checkFileList = [[NSMutableArray alloc] init];
    self.planFileList = [[NSMutableArray alloc] init];
    self.emissionFileList = [[NSMutableArray alloc] init];
    self.workRoomFileList = [[NSMutableArray alloc] init];
    self.processFileList = [[NSMutableArray alloc] init];
    self.otherLiveFileList = [[NSMutableArray alloc] init];
    
    self.licenseFileListS = [[NSMutableArray alloc] init];
    self.eiaFileListS = [[NSMutableArray alloc] init];
    self.checkFileListS = [[NSMutableArray alloc] init];
    self.planFileListS = [[NSMutableArray alloc] init];
    self.emissionFileListS = [[NSMutableArray alloc] init];
    self.workRoomFileListS = [[NSMutableArray alloc] init];
    self.processFileListS = [[NSMutableArray alloc] init];
    self.otherLiveFileListS = [[NSMutableArray alloc] init];
    
    if ([[self.dicDetail allKeys] containsObject:@"licenseFileList"]) {
        self.licenseFileList = [NSMutableArray arrayWithArray:self.dicDetail[@"licenseFileList"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"eiaFileList"]) {
        self.eiaFileList = [NSMutableArray arrayWithArray:self.dicDetail[@"eiaFileList"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"checkFileList"]) {
        self.checkFileList = [NSMutableArray arrayWithArray:self.dicDetail[@"checkFileList"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"planFileList"]) {
        self.planFileList = [NSMutableArray arrayWithArray:self.dicDetail[@"planFileList"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"emissionFileList"]) {
        self.emissionFileList = [NSMutableArray arrayWithArray:self.dicDetail[@"emissionFileList"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"workRoomFileList"]) {
        self.workRoomFileList = [NSMutableArray arrayWithArray:self.dicDetail[@"workRoomFileList"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"processFileList"]) {
        self.processFileList = [NSMutableArray arrayWithArray:self.dicDetail[@"processFileList"]];
    }
    
    if ([[self.dicDetail allKeys] containsObject:@"otherLiveFileList"]) {
        self.otherLiveFileList = [NSMutableArray arrayWithArray:self.dicDetail[@"otherLiveFileList"]];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 24)];
    label.backgroundColor = RGBCOLOR(250, 241, 218);
    label.textColor = RGBCOLOR(251, 199, 88);
    label.text = @"             点击左侧名录可展开图片文件";
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    //默认打开第二section
    _sectionStatus = [NSMutableArray arrayWithObjects:@1,@2,@2,@2, @2,@2,@2,@2, nil];
    //  UICollectionView 的使用
    UICollectionViewFlowLayout *flowlayoutS = [[UICollectionViewFlowLayout alloc] init];
    flowlayoutS.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayoutS.itemSize = CGSizeMake((self.view.frame.size.width - 50) / 4, (self.view.frame.size.width - 50) / 4);
    flowlayoutS.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, kDeviceWidth, kDeviceHeight - NavRect - StatusRect - 130) collectionViewLayout:flowlayoutS];
    self.photoCollectionView.backgroundColor = BackgroundBlack;
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    [self.view addSubview: self.photoCollectionView];
    
    [self.photoCollectionView registerNib:[UINib nibWithNibName:@"PhotographCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PhotographCollectionViewCell"];
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updateBtn.frame = CGRectMake(30, self.photoCollectionView.frame.origin.y + self.photoCollectionView.frame.size.height + 20, kDeviceWidth - 60, 50);
    [updateBtn addTarget:self action:@selector(updateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [updateBtn.layer setCornerRadius:8.0];
    [updateBtn setTitle:@"提交并更新企业档案" forState:UIControlStateNormal];
    updateBtn.backgroundColor = TabbarBlack_S;
    [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:updateBtn];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.titleArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([_sectionStatus[section] isEqualToNumber:@3] || [_sectionStatus[section] isEqualToNumber:@2]) {
        return 0;
    }else {
        if (section == 0) {
            return self.licenseFileList.count;
        } else if (section == 1) {
            return self.eiaFileList.count;
        } else if (section == 2) {
            return self.checkFileList.count;
        } else if (section == 3) {
            return self.planFileList.count;
        } else if (section == 4) {
            return self.emissionFileList.count;
        } else if (section == 5) {
            return self.workRoomFileList.count;
        } else if (section == 6) {
            return self.processFileList.count;
        } else if (section == 7) {
            return self.otherLiveFileList.count;
        }
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indtifer = @"PhotographCollectionViewCell";
    PhotographCollectionViewCell *cell = [self.photoCollectionView dequeueReusableCellWithReuseIdentifier:indtifer forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        [cell.chooseBtn setImage:IMAGENAMED(@"image_close") forState:UIControlStateNormal];
        [cell.imageViewP sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImagePdfVideoFileUrl, self.licenseFileList[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
        [cell.chooseBtn addTarget:self action:@selector(remove1BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.chooseBtn.tag = indexPath.row + 300;
        
        
    } else if (indexPath.section == 1) {
        [cell.chooseBtn setImage:IMAGENAMED(@"image_close") forState:UIControlStateNormal];
        [cell.imageViewP sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImagePdfVideoFileUrl, self.eiaFileList[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
        [cell.chooseBtn addTarget:self action:@selector(remove2BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.chooseBtn.tag = indexPath.row + 400;
        
        
    } else if (indexPath.section == 2) {
        
        [cell.chooseBtn setImage:IMAGENAMED(@"image_close") forState:UIControlStateNormal];
        [cell.imageViewP sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImagePdfVideoFileUrl, self.checkFileList[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
        [cell.chooseBtn addTarget:self action:@selector(remove3BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.chooseBtn.tag = indexPath.row + 500;
        
        
    } else if (indexPath.section == 3) {
        
        [cell.chooseBtn setImage:IMAGENAMED(@"image_close") forState:UIControlStateNormal];
        [cell.imageViewP sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImagePdfVideoFileUrl, self.planFileList[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
        [cell.chooseBtn addTarget:self action:@selector(remove4BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.chooseBtn.tag = indexPath.row + 600;
        
    } else if (indexPath.section == 4) {
        
        [cell.chooseBtn setImage:IMAGENAMED(@"image_close") forState:UIControlStateNormal];
        [cell.imageViewP sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImagePdfVideoFileUrl, self.emissionFileList[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
        [cell.chooseBtn addTarget:self action:@selector(remove5BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.chooseBtn.tag = indexPath.row + 700;
        
    } else if (indexPath.section == 5) {
        
        [cell.chooseBtn setImage:IMAGENAMED(@"image_close") forState:UIControlStateNormal];
        [cell.imageViewP sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImagePdfVideoFileUrl, self.workRoomFileList[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
        [cell.chooseBtn addTarget:self action:@selector(remove6BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.chooseBtn.tag = indexPath.row + 800;
        
    } else if (indexPath.section == 6) {
        
        [cell.chooseBtn setImage:IMAGENAMED(@"image_close") forState:UIControlStateNormal];
        [cell.imageViewP sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImagePdfVideoFileUrl, self.processFileList[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
        [cell.chooseBtn addTarget:self action:@selector(remove7BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.chooseBtn.tag = indexPath.row + 900;
        
        
    } else if (indexPath.section == 7) {
        [cell.chooseBtn setImage:IMAGENAMED(@"image_close") forState:UIControlStateNormal];
        [cell.imageViewP sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImagePdfVideoFileUrl, self.otherLiveFileList[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"loadImage"]];
        [cell.chooseBtn addTarget:self action:@selector(remove8BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.chooseBtn.tag = indexPath.row + 1000;
        
    }
    return cell;
}

- (void)remove1BtnAction:(UIButton *)button {
    if (self.licenseFileList.count > button.tag - 300) {
        [self.licenseFileList removeObjectAtIndex:button.tag - 300];
    }
    if (self.licenseFileListS.count > button.tag - 300) {
        [self.licenseFileListS removeObjectAtIndex:button.tag - 300];
    }
    [self.photoCollectionView reloadData];
}

- (void)remove2BtnAction:(UIButton *)button {
    if (self.eiaFileList.count > button.tag - 400) {
        [self.eiaFileList removeObjectAtIndex:button.tag - 400];
    }
    if (self.eiaFileListS.count > button.tag - 400) {
        [self.eiaFileListS removeObjectAtIndex:button.tag - 400];
    }
    [self.photoCollectionView reloadData];
}

- (void)remove3BtnAction:(UIButton *)button {
    if (self.checkFileList.count > button.tag - 500) {
        [self.checkFileList removeObjectAtIndex:button.tag - 500];
    }
    if (self.checkFileListS.count > button.tag - 500) {
        [self.checkFileListS removeObjectAtIndex:button.tag - 500];
    }
    [self.photoCollectionView reloadData];
}

- (void)remove4BtnAction:(UIButton *)button {
    if (self.planFileList.count > button.tag - 600) {
        [self.planFileList removeObjectAtIndex:button.tag - 600];
    }
    if (self.planFileListS.count > button.tag - 600) {
        [self.planFileListS removeObjectAtIndex:button.tag - 600];
    }
    [self.photoCollectionView reloadData];
}

- (void)remove5BtnAction:(UIButton *)button {
    if (self.emissionFileList.count > button.tag - 700) {
        [self.emissionFileList removeObjectAtIndex:button.tag - 700];
    }
    if (self.emissionFileListS.count > button.tag - 700) {
        [self.emissionFileListS removeObjectAtIndex:button.tag - 700];
    }
    [self.photoCollectionView reloadData];
}

- (void)remove6BtnAction:(UIButton *)button {
    if (self.workRoomFileList.count > button.tag - 800) {
        [self.workRoomFileList removeObjectAtIndex:button.tag - 800];
    }
    if (self.workRoomFileListS.count > button.tag - 800) {
        [self.workRoomFileListS removeObjectAtIndex:button.tag - 800];
    }
    [self.photoCollectionView reloadData];
}

- (void)remove7BtnAction:(UIButton *)button {
    if (self.processFileList.count > button.tag - 900) {
        [self.processFileList removeObjectAtIndex:button.tag - 900];
    }
    if (self.processFileListS.count > button.tag - 900) {
        [self.processFileListS removeObjectAtIndex:button.tag - 900];
    }
    [self.photoCollectionView reloadData];
}

- (void)remove8BtnAction:(UIButton *)button {
    if (self.otherLiveFileList.count > button.tag - 1000) {
        [self.otherLiveFileList removeObjectAtIndex:button.tag - 1000];
    }
    if (self.otherLiveFileListS.count > button.tag - 1000) {
        [self.otherLiveFileListS removeObjectAtIndex:button.tag - 1000];
    }
    [self.photoCollectionView reloadData];
}

#pragma mark <UICollectionViewDelegate>
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.frame.size.width - 50) / 4, (self.view.frame.size.width - 50) / 4);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

// 要先设置表头大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
    return size;
}
 
// 创建一个继承collectionReusableView的类,用法类比tableViewcell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
       UICollectionReusableView *reusableView = nil;
    
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            
             [collectionView registerNib:[UINib nibWithNibName:@"ImageDetailHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ImageDetailHeaderView"];
            
            ImageDetailHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ImageDetailHeaderView" forIndexPath:indexPath];
            [headerView.takingPicturesBtn addTarget:self action:@selector(takingPicturesBtn:) forControlEvents:UIControlEventTouchUpInside];
            headerView.takingPicturesBtn.tag = 1500 + indexPath.section;
            [headerView setAddUITapGestureRecognizer];
            headerView.backgroundColor = [UIColor lightTextColor];
            headerView.titleLabel.text = self.titleArray[indexPath.section];
            int status = [_sectionStatus[indexPath.section] intValue];
            [headerView updateWithStatus:status];
            __weak typeof (self)blockSelf = self;
            headerView.block =^{
                for (int i = 0; i < blockSelf.sectionStatus.count; i ++) {
                    if (i != indexPath.section ) {
                        if ([blockSelf.sectionStatus[i] isEqualToNumber:@1]) {
                            [blockSelf.sectionStatus replaceObjectAtIndex:i withObject:@2];//close others
                            [blockSelf.photoCollectionView reloadSections:[NSIndexSet indexSetWithIndex:i]];
                            break;
                        }
                    }
                }
                int status = [blockSelf.sectionStatus[indexPath.section] intValue];
                NSNumber *num = (status == 3 || status == 2 )? @1 :@2;
                [blockSelf.sectionStatus replaceObjectAtIndex:indexPath.section withObject:num];
                //重新加载当前区
                [blockSelf.photoCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
            };
            
            reusableView = headerView;
        } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            // 底部视图
        }
        return reusableView;
}

- (void)takingPicturesBtn:(UIButton *)button {
    [self setChoooseImageIndex:button.tag - 1500];
}

- (void)setChoooseImageIndex:(NSInteger)index {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:100 columnNumber:1 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    //    if (self.maxCountTF.text.integerValue > 1) {
    // 1.设置目前已经选中的图片数组
    //    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    //    }
    
    if (index == 0) {
        if (([[self.dicDetail allKeys] containsObject:@"licenseFileList"] && [self.dicDetail[@"licenseFileList"] count] == 0) || ![[self.dicDetail allKeys] containsObject:@"licenseFileList"]) {
            imagePickerVc.selectedAssets = self.licenseFileListS;
        }
    } else if (index == 1) {
        if (([[self.dicDetail allKeys] containsObject:@"eiaFileList"] && [self.dicDetail[@"eiaFileList"] count] == 0) || ![[self.dicDetail allKeys] containsObject:@"eiaFileList"]) {
            imagePickerVc.selectedAssets = self.eiaFileListS;
        }
    } else if (index == 2) {
        if (([[self.dicDetail allKeys] containsObject:@"checkFileList"] && [self.dicDetail[@"checkFileList"] count] == 0) || ![[self.dicDetail allKeys] containsObject:@"checkFileList"]) {
            imagePickerVc.selectedAssets = self.checkFileListS;
        }
    } else if (index == 3) {
        if (([[self.dicDetail allKeys] containsObject:@"planFileList"] && [self.dicDetail[@"planFileList"] count] == 0) || ![[self.dicDetail allKeys] containsObject:@"planFileList"]) {
            imagePickerVc.selectedAssets = self.planFileListS;
        }
    } else if (index == 4) {
        if (([[self.dicDetail allKeys] containsObject:@"emissionFileList"] && [self.dicDetail[@"emissionFileList"] count] == 0) || ![[self.dicDetail allKeys] containsObject:@"emissionFileList"]) {
            imagePickerVc.selectedAssets = self.emissionFileListS;
        }
    } else if (index == 5) {
        if (([[self.dicDetail allKeys] containsObject:@"workRoomFileList"] && [self.dicDetail[@"workRoomFileList"] count] == 0) || ![[self.dicDetail allKeys] containsObject:@"workRoomFileList"]) {
            imagePickerVc.selectedAssets = self.workRoomFileListS;
        }
    } else if (index == 6) {
        if (([[self.dicDetail allKeys] containsObject:@"processFileList"] && [self.dicDetail[@"processFileList"] count] == 0) || ![[self.dicDetail allKeys] containsObject:@"processFileList"]) {
            imagePickerVc.selectedAssets = self.processFileListS;
        }
    } else if (index == 7) {
        if (([[self.dicDetail allKeys] containsObject:@"otherLiveFileList"] && [self.dicDetail[@"otherLiveFileList"] count] == 0) || ![[self.dicDetail allKeys] containsObject:@"otherLiveFileList"]) {
            imagePickerVc.selectedAssets = self.otherLiveFileListS;
        }
    }
    
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
            
            [self setUploadNet:arrayImage type:@"image" index:index];
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


- (void)setUploadNet:(NSArray *)arrayUpload type:(NSString *)type index:(NSInteger)index{  //  上传请求
    
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

            for (int i = 0; i < [responseDict[@"result"] count]; i++) {
                if (index == 0) {
                    [self.licenseFileList addObject:responseDict[@"result"][i][@"id"]];
                    [self.licenseFileListS addObject:arrayUpload[i]];
                } else if (index == 1) {
                    [self.eiaFileList addObject:responseDict[@"result"][i][@"id"]];
                    [self.eiaFileListS addObject:arrayUpload[i]];
                } else if (index == 2) {
                    [self.checkFileList addObject:responseDict[@"result"][i][@"id"]];
                    [self.checkFileListS addObject:arrayUpload[i]];
                } else if (index == 3) {
                    [self.planFileList addObject:responseDict[@"result"][i][@"id"]];
                    [self.planFileListS addObject:arrayUpload[i]];
                } else if (index == 4) {
                    [self.emissionFileList addObject:responseDict[@"result"][i][@"id"]];
                    [self.emissionFileListS addObject:arrayUpload[i]];
                } else if (index == 5) {
                    [self.workRoomFileList addObject:responseDict[@"result"][i][@"id"]];
                    [self.workRoomFileListS addObject:arrayUpload[i]];
                } else if (index == 6) {
                    [self.processFileList addObject:responseDict[@"result"][i][@"id"]];
                    [self.processFileListS addObject:arrayUpload[i]];
                } else if (index == 7) {
                    [self.otherLiveFileList addObject:responseDict[@"result"][i][@"id"]];
                    [self.otherLiveFileListS addObject:arrayUpload[i]];
                }
            }

            [self.photoCollectionView reloadData];

        }
        [SVProgressHUD showInfoWithStatus:responseDict[@"message"]];
    
        return ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n\n --------------- \n\n failure : %@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)updateBtnAction {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSString stringWithFormat:@"%@", self.dicDetail[@"id"]]  forKey:@"id"];
    
    if (self.licenseFileList.count > 0) {
        [dic setObject:self.licenseFileList forKey:@"licenseFileList"];
    }
    
    if (self.eiaFileList.count > 0) {
        [dic setObject:self.eiaFileList forKey:@"eiaFileList"];
    }
    
    if (self.checkFileList.count > 0) {
        [dic setObject:self.checkFileList forKey:@"checkFileList"];
    }
    
    if (self.planFileList.count > 0) {
        [dic setObject:self.planFileList forKey:@"planFileList"];
    }
    
    if (self.emissionFileList.count > 0) {
        [dic setObject:self.emissionFileList forKey:@"emissionFileList"];
    }
    
    if (self.workRoomFileList.count > 0) {
        [dic setObject:self.workRoomFileList forKey:@"workRoomFileList"];
    }
    
    if (self.processFileList.count > 0) {
        [dic setObject:self.processFileList forKey:@"processFileList"];
    }
    
    if (self.otherLiveFileList.count > 0) {
        [dic setObject:self.otherLiveFileList forKey:@"otherLiveFileList"];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"提交中...";
    
    [NetworkHandler requestPostWithUrl:API_BASE_URL(@"enterprise/update") parameters:@{@"entity":dic} view:nil completion:^(id result) {
        
        if ([result[@"isSuccess"] intValue] == 1) {
            
            self.reloadBlock(@"success");
            [self.navigationController popViewControllerAnimated:YES];
            
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
