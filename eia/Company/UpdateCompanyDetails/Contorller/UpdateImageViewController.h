//
//  UpdateImageViewController.h
//  eia
//
//  Created by JimmyYue on 2020/6/23.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotographCollectionViewCell.h"
#import "ImageDetailHeaderView.h"
#import "TZImagePickerController.h"
#import "XFCameraController.h"
#import <Photos/Photos.h>
#import "UIView+Layout.h"
#import "AFURLRequestSerialization.h"
#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"
#import "ImagePreview.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdateImageViewController : InheritanceViewController<UICollectionViewDelegate, UICollectionViewDataSource, TZImagePickerControllerDelegate>


@property (nonatomic,copy)void (^reloadBlock)(NSString *type);
@property(nonatomic, strong) NSMutableDictionary *dicDetail;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *sectionStatus;//开关状态
@property (nonatomic, strong) UICollectionView *photoCollectionView;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;

@property (nonatomic, strong) NSMutableArray *licenseFileListS;
@property (nonatomic, strong) NSMutableArray *eiaFileListS;
@property (nonatomic, strong) NSMutableArray *checkFileListS;
@property (nonatomic, strong) NSMutableArray *planFileListS;
@property (nonatomic, strong) NSMutableArray *emissionFileListS;
@property (nonatomic, strong) NSMutableArray *workRoomFileListS;
@property (nonatomic, strong) NSMutableArray *processFileListS;
@property (nonatomic, strong) NSMutableArray *otherLiveFileListS;

@property (nonatomic, strong) NSMutableArray *licenseFileList;
@property (nonatomic, strong) NSMutableArray *eiaFileList;
@property (nonatomic, strong) NSMutableArray *checkFileList;
@property (nonatomic, strong) NSMutableArray *planFileList;
@property (nonatomic, strong) NSMutableArray *emissionFileList;
@property (nonatomic, strong) NSMutableArray *workRoomFileList;
@property (nonatomic, strong) NSMutableArray *processFileList;
@property (nonatomic, strong) NSMutableArray *otherLiveFileList;

@end

NS_ASSUME_NONNULL_END
