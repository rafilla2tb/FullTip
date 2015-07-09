//
//  TutorialSync.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeftLoginViewController.h"

@interface LoginGoogleSync : NSObject
@property (strong, nonatomic) NSMutableArray *LikesItems;
@property (strong, nonatomic) LeftLoginViewController *Delegate;
- (void)PostLoginGoogle:(NSString*)ident name:(NSString*)name email:(NSString*)email avatar:(NSString*)avatar language:(NSString*)language gender:(NSString*)gender push_id:(NSString*)push_id;
@end
