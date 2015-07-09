//
//  TutorialItem.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "MailBoxItem.h"

@implementation MailBoxItem

@synthesize idx;
@synthesize type;
@synthesize date;
@synthesize title;
@synthesize text;
@synthesize Mails;
+ (MailBoxItem*) MailBox {
    static MailBoxItem *instance = nil;
    if (instance==nil) {
        instance = [[MailBoxItem alloc] init];
    }
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}
- (void)AddMail:(MailBoxItem*)Mail{
    /*idx=dash.idx;
    name=dash.name;
    emails_percent=dash.emails_percent;
    recommended_percent=dash.recommended_percent;
    balance=dash.balance;
    potencial_balance=dash.potencial_balance;
    referrals = [[NSMutableArray alloc] initWithArray:dash.referrals];*/
    [Mails addObject:Mail];
}
- (void)InitArray{
    Mails = [[NSMutableArray alloc] init];
}

@end
