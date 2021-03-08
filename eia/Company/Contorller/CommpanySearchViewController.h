//
//  CommpanySearchViewController.h
//  eia
//
//  Created by JimmyYue on 2020/7/3.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyScreenView.h"
#import "HomeSearchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommpanySearchViewController : InheritanceViewController
@property (nonatomic, strong) NSMutableDictionary *dicSearch;
@property (nonatomic,copy)void (^block)(NSMutableDictionary *dic);
@property (nonatomic, strong) CompanyScreenView *companyScreenView;

@end

NS_ASSUME_NONNULL_END
