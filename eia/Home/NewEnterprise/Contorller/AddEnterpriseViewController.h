//
//  AddEnterpriseViewController.h
//  eia
//
//  Created by JimmyYue on 2020/7/4.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicTopChooseEnterpriseView.h"
#import "AddEnterpriseBottomView.h"
#import "MapViewController.h"
#import "ChooseLocationViewController.h"
#import "CityPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddEnterpriseViewController : InheritanceViewController
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *enterpriseText;
@property (nonatomic, strong) BasicTopChooseEnterpriseView *basicTopChooseEnterpriseView;
@property (nonatomic, strong) AddEnterpriseBottomView *addEnterpriseBottomView;

@property (nonatomic, strong) NSString *cityName; // 市


@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;

@end

NS_ASSUME_NONNULL_END
