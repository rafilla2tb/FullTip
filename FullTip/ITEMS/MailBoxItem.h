//
//  TutorialItem.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MailBoxItem : NSObject{
    NSString *idx;
    NSString *type;
    NSString *date;
    NSString *title;
    NSString *text;
    NSMutableArray *Mails;
}
@property (strong, nonatomic) NSString *idx;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSMutableArray *Mails;

+ (MailBoxItem*) MailBox;
- (void)AddMail:(MailBoxItem*)Mail;
- (void)InitArray;
@end
