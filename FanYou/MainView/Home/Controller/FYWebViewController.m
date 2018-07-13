//
//  FYWebViewController.m
//  FanYou
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYWebViewController.h"

@interface FYWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation FYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - StatusHeight - 44 - BarBottomHeight)];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    self.webview.navigationDelegate = self;
    self.webview.UIDelegate = self;
    //开了支持滑动返回
    self.webview.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webview];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    self.title = webView.title;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    self.title = @"加载失败，请返回重试";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
