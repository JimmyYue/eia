//
//  HomeViewController.h
//  eia
//
//  Created by JimmyYue on 2020/4/16.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeSearchViewController.h"
#import "Production+CoreDataClass.h"
#import "HMCoreDataStackManager.h"
#import <PgyUpdate/PgyUpdateManager.h>
#import "SceneDelegate.h"
#import "HomeAllowView.h"
#import "HomeWeatherView.h"
#import "HomePatrolView.h"
#import "HomeTypeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) HomeAllowView *homeAllowView;
@property (strong, nonatomic) HomeWeatherView *homeWeatherView;
@property (strong, nonatomic) HomePatrolView *homePatrolView;
@property (strong, nonatomic) HomeTypeView *homeTypeView;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
