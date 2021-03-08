//
//  ParkEnterprisesDetailBottomView.h
//  eia
//
//  Created by JimmyYue on 2020/6/20.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParkEnterprisesDetailBottomView : UIView

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UIButton *addPatrolBtn;

@property (strong, nonatomic) IBOutlet UIButton *updateBtn;

@property (strong, nonatomic) IBOutlet UIButton *allAddPatrolBtn;

@end

NS_ASSUME_NONNULL_END
