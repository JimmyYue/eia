//
//  CompanyBottomView.h
//  eia
//
//  Created by JimmyYue on 2020/7/2.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanyBottomView : UIView

@property (strong, nonatomic) IBOutlet UILabel *pageLabel;

@property (strong, nonatomic) IBOutlet UIButton *beforePageBtn;

@property (strong, nonatomic) IBOutlet UIButton *afterPageBtn;

@property (strong, nonatomic) IBOutlet UIButton *pushBtn;

@end

NS_ASSUME_NONNULL_END
