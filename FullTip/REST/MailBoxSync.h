//
//  TutorialSync.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface MailBoxSync : NSObject
@property (strong, nonatomic) NSMutableArray *MailBoxItems;
@property (strong, nonatomic) ViewController *Delegate;
- (void)getMailBoxInfo;
@end
