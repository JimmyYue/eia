//
//  InspectTheProgressHeaderView.h
//  eia
//
//  Created by JimmyYue on 2020/7/8.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InspectTheProgressHeaderView : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *toLabel;

@property (strong, nonatomic) IBOutlet UIButton *starTimeBtn;

@property (strong, nonatomic) IBOutlet UIButton *endTimeBtn;

@end

NS_ASSUME_NONNULL_END
