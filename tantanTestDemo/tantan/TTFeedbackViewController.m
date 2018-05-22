//
//  TTFeedbackViewController.m
//  tantanTestDemo
//
//  Created by puzhiguang on 2018/5/22.
//  Copyright © 2018年 puzhiguang. All rights reserved.
//

#import "TTFeedbackViewController.h"
#import "AlertBox.h"


@interface TTFeedbackViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *uiwebView;

@end

@implementation TTFeedbackViewController

- (instancetype)initWithUrl:(NSURL*)url {
    if (self = [self init]) {
        self.url = url;
    }
    return self;
}


#pragma mark life cycle;
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadRequest];
    self.navigationItem.title = @"探探反馈调起页面";
    [self openUrlIos9OrAbove:self.url];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadRequest {
    [self.uiwebView loadRequest:[NSURLRequest requestWithURL:self.url]];
}


#pragma mark webview delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSCachedURLResponse *resp = [[NSURLCache sharedURLCache] cachedResponseForRequest:webView.request];
    if ([(NSHTTPURLResponse*)resp.response statusCode ]== 404)
    {
        return;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //当同时收到两个一样的请求时，webview会自动cancle其中一个，并抛出一个 -999的errorCode，但并不影响页面加载，此处不做错误页面提示
    if ([self isSpecialCancle:error.code]) {
        return;
    }
}

- (BOOL)isSpecialCancle:(NSInteger)code {
    switch (code) {
        case -999:
            return YES;
            break;
        case -1003:
            return YES;
            break;
        case 204:
            return YES;//加载插件
            break;
        default:
            return NO;
            break;
    }
}

-(void) openUrlIos9OrAbove:(NSURL *)url
{
    /*IOS10OrAbove
     {
     NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @YES};
     [[UIApplication sharedApplication] openURL:url options:options completionHandler:nil];
     }
     else{
     [[UIApplication sharedApplication] openURL:url];
     }*/
    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        if (@available(iOS 10.0, *)) {
            [application openURL:url options:@{}
               completionHandler:^(BOOL success) {
                   NSLog(@"Open %@: %d",url,success);
                   NSString *str = [NSString stringWithFormat:@"当前没有安装探探软件，无法开启探探反馈功能，请安装后再试(%@)",url];
                   [AlertBox showMessage:str hideAfter:2.f];

               }];
        } else {
            // Fallback on earlier versions
        }
    } else {
        BOOL success = [application openURL:url];
        NSLog(@"Open %@: %d",url,success);
    }
}

@end
