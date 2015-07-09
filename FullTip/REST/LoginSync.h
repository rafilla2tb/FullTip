//
//  TutorialSync.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeftLoginViewController.h"

@interface LoginSync : NSObject
@property (strong, nonatomic) NSMutableArray *LikesItems;
@property (strong, nonatomic) LeftLoginViewController *Delegate;
- (void)PostLoginWithMail:(NSString*)mail withPassWord:(NSString*)pass;
@end
