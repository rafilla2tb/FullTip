//
//  TutorialSync.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecInmueblesViewController.h"

@interface LeadSync : NSObject

@property (strong, nonatomic) RecInmueblesViewController *Delegate;
- (void)postLeadInfo:(NSArray*)data withMail:(NSString*)mail;
@end
