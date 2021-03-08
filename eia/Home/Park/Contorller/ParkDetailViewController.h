//
//  ParkDetailViewController.h
//  eia
//
//  Created by JimmyYue on 2020/4/29.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewParkViewController.h"
#import "InheritanceViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParkDetailViewController : InheritanceViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic,copy)void (^block)(NSDictionary *dic);
@property (nonatomic, strong) NSString *parkCode;
@property (nonatomic, strong) NSDictionary *detailDic;

@end

NS_ASSUME_NONNULL_END
