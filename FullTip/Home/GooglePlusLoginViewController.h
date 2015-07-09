//
//  GooglePlusLoginViewController.h
//  FullTip
//
//  Created by rafilla on 30/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GooglePlusLoginViewController : UIViewController<UIWebViewDelegate>{
    IBOutlet UIWebView *WebViewLog;
}
@property (strong, nonatomic) IBOutlet UIWebView *WebViewLog;

@end
