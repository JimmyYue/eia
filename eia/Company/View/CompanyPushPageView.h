//
//  CompanyPushPageView.h
//  eia
//
//  Created by JimmyYue on 2020/7/2.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanyPushPageView : UIView

- (void)setAllowCompanyPushPageView:(NSString *)totalPageCount start:(NSString *)start;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UITextField *pageText;
@property (nonatomic,copy)void (^block)(int start);
@property (nonatomic, strong) NSString *totalPageCount;
@end

NS_ASSUME_NONNULL_END
