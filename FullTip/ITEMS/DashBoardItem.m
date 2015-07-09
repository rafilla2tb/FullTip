//
//  TutorialItem.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "DashBoardItem.h"

@implementation DashBoardItem
@synthesize idx;
@synthesize name;
@synthesize emails_percent;
@synthesize recommended_percent;
@synthesize balance;
@synthesize potencial_balance;
@synthesize referrals;
+ (DashBoardItem*) DashBoard {
    static DashBoardItem *instance = nil;
    if (instance==nil) {
        instance = [[DashBoardItem alloc] init];
    }
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
        referrals = [[NSMutableArray alloc] init];
    }
    
    return self;
}
- (void)setFullData:(DashBoardItem*)dash{
    idx=dash.idx;
    name=dash.name;
    emails_percent=dash.emails_percent;
    recommended_percent=dash.recommended_percent;
    balance=dash.balance;
    potencial_balance=dash.potencial_balance;
    referrals = [[NSMutableArray alloc] initWithArray:dash.referrals];
}

@end
@implementation ReferralItem


@end