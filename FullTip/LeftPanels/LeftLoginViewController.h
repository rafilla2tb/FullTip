//
//  LeftLoginViewController.h
//  FullTip
//
//  Created by rafilla on 23/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>
@class ViewController;
@class GPPSignInButton;
@interface LeftLoginViewController : UIViewController<UIAlertViewDelegate,GPPSignInDelegate>{
    BOOL called;
GPPSignIn *signIn;
}
@property (weak, nonatomic) IBOutlet UIView *LogView;
@property (weak, nonatomic) IBOutlet UIView *RegLog;
@property (weak, nonatomic) IBOutlet UITextField *LogMail;
@property (weak, nonatomic) IBOutlet UITextField *LogPass;
@property (weak, nonatomic) IBOutlet UITextField *NameReg;
@property (weak, nonatomic) IBOutlet UITextField *LastNameReg;
@property (weak, nonatomic) IBOutlet UITextField *MailReg;
@property (weak, nonatomic) IBOutlet UITextField *PassReg;
@property (weak, nonatomic) IBOutlet UITextField *RepPassReg;
@property (strong, nonatomic) ViewController *Delegate;
@property(weak, nonatomic) IBOutlet GPPSignInButton *signInButton;
@property (strong, nonatomic) GPPSignIn *signIn;


- (void)LogOk;
- (void)RegOk;
- (void)ForgotOk;
@end
