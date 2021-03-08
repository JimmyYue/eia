//
//  TourPlanView.h
//  eia
//
//  Created by JimmyYue on 2020/9/2.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TourPlanView : UIView

@property (strong, nonatomic) IBOutlet UIButton *unfinishedBtn;

@property (strong, nonatomic) IBOutlet UILabel *unfinishedLabel;

@property (strong, nonatomic) IBOutlet UIButton *planBtb;

@property (strong, nonatomic) IBOutlet UILabel *planLabel;




@end

NS_ASSUME_NONNULL_END
