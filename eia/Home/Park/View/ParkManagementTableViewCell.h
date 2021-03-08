//
//  ParkManagementTableViewCell.h
//  eia
//
//  Created by JimmyYue on 2020/4/29.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewParkViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParkManagementTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end

NS_ASSUME_NONNULL_END
