//
//  ImagePreview.m
//  HouseKeeper
//
//  Created by JimmyYue on 2018/11/27.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "ImagePreview.h"

@implementation ImagePreview

- (void)setImagePreview {
    
    self.backgroundColor = [UIColor blackColor];

    if (self.view) {
        [self.view.window addSubview:self];
    } else {
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        [window addSubview:self];
    }
    
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.selectionGranularity = WKSelectionGranularityDynamic;
    config.allowsInlineMediaPlayback = YES;
    WKPreferences *preferences = [WKPreferences new];
    //是否支持JavaScript
    preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preferences;
    
//    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    [wkUController addUserScript:wkUScript];
//    config.userContentController = wkUController;
    
    self.webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, (kDeviceHeight - kDeviceWidth * 4 / 3) / 2, kDeviceWidth, kDeviceWidth * 4 / 3) configuration:config];
    self.webview.backgroundColor = [UIColor blackColor];
    self.webview.navigationDelegate = self;
    self.webview.UIDelegate = self;
    self.webview.opaque = NO;//背景不透明设置为N
    [self addSubview:self.webview];

    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(kDeviceWidth / 2 - 25, self.webview.frame.origin.y + self.webview.frame.size.height + ((kDeviceHeight - kDeviceWidth * 4 / 3) / 2 - 50) / 2, 50, 50);
    [searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setBackgroundImage:IMAGENAMED(@"my_close") forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:searchBtn];
}

- (void)searchBtnAction {
    [self removeFromSuperview];
}

- (void)setFileCode:(NSString *)code {
    self.fileURLString = [NSString stringWithFormat:@"%@%@?zoom=1.0", ImagePdfVideoFileUrl, code];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.fileURLString]];
    [self.webview loadRequest:request];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
