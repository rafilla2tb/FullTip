//
//  TutorialSync.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeftLoginViewController.h"

@interface RegisterSync : NSObject
@property (strong, nonatomic) NSMutableArray *LikesItems;
@property (strong, nonatomic) LeftLoginViewController *Delegate;
- (void)PostRegisterWithMail:(NSString*)mail withPassWord:(NSString*)pass withRepeatPassword:(NSString*)passRep withPushId:(NSString*)push withName:(NSString*)name;
@end
