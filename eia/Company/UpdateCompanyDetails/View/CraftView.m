//
//  CraftView.m
//  eia
//
//  Created by JimmyYue on 2020/4/22.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "CraftView.h"

@implementation CraftView

- (void)setAllowCraftView {
    
    self.imageBtn.hidden = YES;
    
    _speciesText = [XBTextView textViewWithPlaceHolder:@"填写本次检查的结果说明"];
    _speciesText.frame = CGRectMake(10, 50, kDeviceWidth - 30, 120);
    _speciesText.maxTextCount = 2000;
    _speciesText.textView.backgroundColor = BackgroundBlack;
    _speciesText.layer.cornerRadius = 8.0f;
    _speciesText.textView.font = [UIFont systemFontOfSize:15];
    _speciesText.textCountLabel.hidden = YES;
    _speciesText.backgroundColor = BackgroundBlack;
    [self addSubview:_speciesText];
    
    _productionText = [XBTextView textViewWithPlaceHolder:@"填写本次检查的结果说明"];
    _productionText.frame = CGRectMake(10, 245, kDeviceWidth - 30, 120);
    _productionText.maxTextCount = 2000;
    _productionText.textView.backgroundColor = BackgroundBlack;
    _productionText.layer.cornerRadius = 8.0f;
    _productionText.textView.font = [UIFont systemFontOfSize:15];
    _productionText.textCountLabel.hidden = YES;
    _productionText.backgroundColor = BackgroundBlack;
    [self addSubview:_productionText];
    
    _riskText = [XBTextView textViewWithPlaceHolder:@"填写本次检查的结果说明"];
    _riskText.frame = CGRectMake(10, 445, kDeviceWidth - 30, 120);
    _riskText.maxTextCount = 2000;
    _riskText.textView.backgroundColor = BackgroundBlack;
    _riskText.layer.cornerRadius = 8.0f;
    _riskText.textView.font = [UIFont systemFontOfSize:15];
    _riskText.textCountLabel.hidden = YES;
    _riskText.backgroundColor = BackgroundBlack;
    [self addSubview:_riskText];
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
