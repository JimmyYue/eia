//
//  IndustryClassificationView.m
//  eia
//
//  Created by JimmyYue on 2020/6/30.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "IndustryClassificationView.h"

@implementation IndustryClassificationView

- (void)setAllowIndustryClassificationView {
    
    UIView *levelFText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.levelFText.leftView = levelFText;
    self.levelFText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *levelSText = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.levelSText.leftView = levelSText;
    self.levelSText.leftViewMode = UITextFieldViewModeAlways;
    
    self.reportText = [XBTextView textViewWithPlaceHolder:@"年出栏生猪 5000 头(其他畜禽种类折合猪的养殖 规模)及以上;涉及环境敏感区的"];
    self.reportText.frame = CGRectMake(10, 175, self.frame.size.width - 20, 100);
    self.reportText.maxTextCount = 2000;
    self.reportText.textView.backgroundColor = [UIColor clearColor];
    self.reportText.layer.cornerRadius = 8.0f;
    self.reportText.textView.font = [UIFont systemFontOfSize:15];
    self.reportText.textCountLabel.hidden = YES;
    self.reportText.backgroundColor = BackgroundBlack;
    [self addSubview:self.reportText];
    
    
    self.reportSText = [XBTextView textViewWithPlaceHolder:@"/"];
    self.reportSText.frame = CGRectMake(10, 320, self.frame.size.width - 20, 100);
    self.reportSText.maxTextCount = 2000;
    self.reportSText.textView.backgroundColor = [UIColor clearColor];
    self.reportSText.layer.cornerRadius = 8.0f;
    self.reportSText.textView.font = [UIFont systemFontOfSize:15];
    self.reportSText.textCountLabel.hidden = YES;
    self.reportSText.backgroundColor = BackgroundBlack;
    [self addSubview:self.reportSText];
    
    
    self.registrationText = [XBTextView textViewWithPlaceHolder:@"其他"];
    self.registrationText.frame = CGRectMake(10, 465, self.frame.size.width - 20, 100);
    self.registrationText.maxTextCount = 2000;
    self.registrationText.textView.backgroundColor = [UIColor clearColor];
    self.registrationText.layer.cornerRadius = 8.0f;
    self.registrationText.textView.font = [UIFont systemFontOfSize:15];
    self.registrationText.textCountLabel.hidden = YES;
    self.registrationText.backgroundColor = BackgroundBlack;
    [self addSubview:self.registrationText];
    
    
    self.sensitiveText = [XBTextView textViewWithPlaceHolder:@"第三条(一)中的全部区域; 第三条(三)中的全部区域"];
    self.sensitiveText.frame = CGRectMake(10, 610, self.frame.size.width - 20, 100);
    self.sensitiveText.maxTextCount = 2000;
    self.sensitiveText.textView.backgroundColor = [UIColor clearColor];
    self.sensitiveText.layer.cornerRadius = 8.0f;
    self.sensitiveText.textView.font = [UIFont systemFontOfSize:15];
    self.sensitiveText.textCountLabel.hidden = YES;
    self.sensitiveText.backgroundColor = BackgroundBlack;
    [self addSubview:self.sensitiveText];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
