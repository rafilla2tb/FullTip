//
//  GooglePlusLoginViewController.m
//  FullTip
//
//  Created by rafilla on 30/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "GooglePlusLoginViewController.h"

@interface GooglePlusLoginViewController ()

@end

@implementation GooglePlusLoginViewController
@synthesize WebViewLog;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [WebViewLog setDelegate:self];
    NSString* url = @"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/google";
    
    NSURL* nsUrl = [NSURL URLWithString:url];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    
    //[WebViewLog loadRequest:request];
    
    /*CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
    WebViewLog = [[UIWebView alloc] initWithFrame:webFrame];
    WebViewLog.delegate = self;
    WebViewLog.scalesPageToFit = YES;
    [self.view addSubview:WebViewLog];
    
    //path of local html file present in documentsDirectory
    
    
    //load file into webView
    [WebViewLog loadRequest:request];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidFinishLoading:(UIWebView *)webView
{
    NSLog(@"loaded");
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"loaded");
    
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
