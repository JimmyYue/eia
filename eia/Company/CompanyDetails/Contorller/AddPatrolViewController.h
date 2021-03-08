//
//  AddPatrolViewController.h
//  eia
//
//  Created by JimmyYue on 2020/6/23.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPatrolHeaderView.h"
#import "PhotographCollectionViewCell.h"
#import "TZImagePickerController.h"
#import "XFCameraController.h"
#import <Photos/Photos.h>
#import "UIView+Layout.h"
#import "AFURLRequestSerialization.h"
#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"
#import "ImagePreview.h"
#import "XBTextView.h"
#import "SignatureViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddPatrolViewController : InheritanceViewController<UICollectionViewDelegate, UICollectionViewDataSource, TZImagePickerControllerDelegate, XBTextViewDelegate>

@property (nonatomic,copy)void (^reloadBlock)(NSString *type);

@property (nonatomic, strong) NSString *EtpId;
@property (nonatomic, strong) AddPatrolHeaderView * headerView;
@property (nonatomic, strong) NSMutableArray *chooseArray;
@property (nonatomic, strong) NSMutableArray *imageCodeArray;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, strong) UICollectionView *photoCollectionView;
@property (nonatomic, strong) NSString *resultsText;
@property (nonatomic, strong) NSString *imageCode;

@end

NS_ASSUME_NONNULL_END
