//
//  ChooseIndustryViewController.h
//  eia
//
//  Created by JimmyYue on 2020/6/30.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndustryClassificationView.h"
#import "ChooseIndustryClassificationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChooseIndustryViewController : InheritanceViewController

@property (nonatomic, strong) IndustryClassificationView *industryClassificationView;
@property (nonatomic, strong) NSMutableArray *arrayF;
@property (nonatomic, strong) NSMutableArray *arrayS;
@property (nonatomic,copy)void (^block)(NSString *industryName);
@property (nonatomic, strong) NSString *titleStr;

@end

NS_ASSUME_NONNULL_END
