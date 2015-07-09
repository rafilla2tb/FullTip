//
//  TutorialItem.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DashBoardItem : NSObject{
    NSString *idx;
    NSString *name;
    NSString *emails_percent;
    NSString *recommended_percent;
    NSString *balance;
    NSString *potencial_balance;
    NSMutableArray *referrals;
}
@property (strong, nonatomic) NSString *idx;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *emails_percent;
@property (strong, nonatomic) NSString *recommended_percent;
@property (strong, nonatomic) NSString *balance;
@property (strong, nonatomic) NSString *potencial_balance;
@property (strong, nonatomic) NSMutableArray *referrals;

+ (DashBoardItem*) DashBoard;
- (void)setFullData:(DashBoardItem*)dash;
@end
@interface ReferralItem : NSObject
@property (strong, nonatomic) NSString *idx;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *category_id;
@property (strong, nonatomic) NSString *category_name;
@property (strong, nonatomic) NSString *query;



@end
