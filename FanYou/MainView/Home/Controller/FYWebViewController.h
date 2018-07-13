//
//  FYWebViewController.h
//  FanYou
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface FYWebViewController : UIViewController

@property (strong,nonatomic) WKWebView * webview;
@property (copy,nonatomic) NSString * webUrl;

@end
