//
//  TutorialSync.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeftLoginViewController.h"
@interface iForgotSync : NSObject <UIAlertViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) LeftLoginViewController *Delegate;
@property (strong, nonatomic) UIAlertView *av;
- (void)iForgot;
- (void)iForgotSend:(NSString*)mail;
@end
