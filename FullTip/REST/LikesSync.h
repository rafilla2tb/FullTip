//
//  TutorialSync.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
@class PopUpCategoriasViewController;
@interface LikesSync : NSObject
@property (strong, nonatomic) NSMutableArray *LikesItems;
@property (strong, nonatomic) ViewController *Delegate;
@property (strong, nonatomic) PopUpCategoriasViewController *LikesDelegate;
- (void)getLikesInfo;
- (void)postLikesInfo:(NSArray*)categories;
@end
