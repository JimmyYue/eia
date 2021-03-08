//
//  HomePatrolView.h
//  eia
//
//  Created by JimmyYue on 2020/9/17.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePatrolView : UIView

@property (strong, nonatomic) IBOutlet UILabel *countNumberLabel;

@property (strong, nonatomic) IBOutlet UILabel *planLabel;

@property (strong, nonatomic) IBOutlet UILabel *focusEditLabel;

@property (strong, nonatomic) IBOutlet UILabel *commonEditLabel;

@property (strong, nonatomic) IBOutlet UILabel *normalLabel;


@end

NS_ASSUME_NONNULL_END
