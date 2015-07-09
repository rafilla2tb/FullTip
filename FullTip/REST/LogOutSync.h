//
//  TutorialSync.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeftUserViewController.h"
@interface LogOutSync : NSObject
@property (strong, nonatomic) LeftUserViewController *Delegate;
- (void)LogOut;
@end
