//
//  TutorialSync.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthSync : NSObject
@property (strong, nonatomic) NSMutableArray *LikesItems;

- (void)PostOAuth;
@end
