//
//  IndustryClassificationView.h
//  eia
//
//  Created by JimmyYue on 2020/6/30.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IndustryClassificationView : UIView

@property (strong, nonatomic) IBOutlet UITextField *levelFText;
@property (strong, nonatomic) IBOutlet UIButton *levelFBtn;

@property (strong, nonatomic) IBOutlet UITextField *levelSText;
@property (strong, nonatomic) IBOutlet UIButton *levelSBtn;

@property(nonatomic, strong) XBTextView *reportText;
@property(nonatomic, strong) XBTextView *reportSText;
@property(nonatomic, strong) XBTextView *registrationText;
@property(nonatomic, strong) XBTextView *sensitiveText;

- (void)setAllowIndustryClassificationView;

@end

NS_ASSUME_NONNULL_END
