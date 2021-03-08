//
//  ImagePreview.h
//  HouseKeeper
//
//  Created by JimmyYue on 2018/11/27.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImagePreview : UIView<WKUIDelegate, WKNavigationDelegate>

- (void)setImagePreview;
- (void)setFileCode:(NSString *)code;

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSURL *fileURL;
@property (nonatomic, strong) NSString *fileURLString;
@property (nonatomic, strong) WKWebView *webview;

@end

NS_ASSUME_NONNULL_END
