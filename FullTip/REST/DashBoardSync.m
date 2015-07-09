//
//  TutorialSync.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "DashBoardSync.h"
#import "DashBoardItem.h"

@implementation DashBoardSync
@synthesize DashBoardItems;
@synthesize Delegate;
- (void)getDashBoardInfo;
{
   
    
    DashBoardItems=[[NSMutableArray alloc]init];
    NSString *IdUser=[[NSUserDefaults standardUserDefaults] objectForKey:@"IdUser"];
    NSString *access_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    
    NSString *postString = [NSString stringWithFormat:@"access_token=%@&oauth-owner=user",access_token];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/%@/dashboard?%@",IdUser,postString]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
   
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
             NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
             NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataDashBoard.json"];
             
             [data writeToFile:jsonPath atomically:YES];
             
             [self backWithData:data];
             
             
         }else{
             [self getCategoryDataFromFile];
         }
     }];
}


- (void)getCategoryDataFromFile;
{
    DashBoardItems=[[NSMutableArray alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
    NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataDashBoard.json"];
    NSData *data=[NSData dataWithContentsOfFile:jsonPath];
    if (data.length > 0 ){
        [self backWithData:data];
    }
    
}
-(void) backWithData:(NSData*)data{
    NSDictionary *DictData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
    NSString *theXml = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"xml-->%@",theXml);
    DashBoardItem *Dash=[[DashBoardItem alloc]init];
    [Dash setIdx:[DictData objectForKey:@"id"]];
    [Dash setName:[DictData objectForKey:@"name"]];
    [Dash setEmails_percent:[DictData objectForKey:@"emails_percent"]];
    [Dash setRecommended_percent:[DictData objectForKey:@"recommended_percent"]];
    [Dash setBalance:[DictData objectForKey:@"balance"]];
    [Dash setPotencial_balance:[DictData objectForKey:@"potencial_balance"]];
    Dash.referrals=[[NSMutableArray alloc]initWithCapacity:0];
    NSArray *RefArray=[[NSArray alloc]initWithArray:[DictData objectForKey:@"referrals"]];
    for (NSDictionary *object in RefArray) {
        ReferralItem *Referral=[[ReferralItem alloc]init];
        [Referral setIdx:[object objectForKey:@"id"]];
        [Referral setName:[object objectForKey:@"name"]];
        [Referral setState:[object objectForKey:@"state"]];
        NSDictionary *Date =[object objectForKey:@"date_create"];
        [Referral setDate:[Date objectForKey:@"date"]];
        [Referral setCategory_id:[object objectForKey:@"category_id"]];
        [Referral setCategory_name:[object objectForKey:@"category_name"]];
        [Referral setQuery:[object objectForKey:@"query"]];
        [Dash.referrals addObject:Referral];
    }
    //[Delegate PaintCategory:CategoryItems];
    
    [[DashBoardItem DashBoard] setFullData:Dash];
    NSLog(@"ee");
}

@end
