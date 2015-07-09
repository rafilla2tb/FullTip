//
//  TutorialSync.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface CategoriasSync : NSObject
@property (strong, nonatomic) NSMutableArray *CategoryItems;
@property (strong, nonatomic) ViewController *Delegate;
- (void)getCategoryInfo;
@end
