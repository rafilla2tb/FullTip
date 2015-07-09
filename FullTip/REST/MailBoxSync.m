//
//  TutorialSync.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "MailBoxSync.h"
#import "MailBoxItem.h"

@implementation MailBoxSync
@synthesize MailBoxItems;
@synthesize Delegate;
- (void)getMailBoxInfo;
{
   
    
    MailBoxItems=[[NSMutableArray alloc]init];
    NSString *IdUser=[[NSUserDefaults standardUserDefaults] objectForKey:@"IdUser"];
    NSString *access_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    
    NSString *postString = [NSString stringWithFormat:@"oauth-owner=user&access_token=%@",access_token];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/%@/mailbox?%@",IdUser,postString]];
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
             NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataMailBox.json"];
             
             [data writeToFile:jsonPath atomically:YES];
             
             [self backWithData:data];
             
             
         }else{
             [self getCategoryDataFromFile];
         }
     }];
}


- (void)getCategoryDataFromFile;
{
    MailBoxItems=[[NSMutableArray alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
    NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataMailBox.json"];
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
    [[MailBoxItem MailBox] InitArray];
     
    NSLog(@"xml-->%@",theXml);
    for (NSDictionary *object in DictData) {
        MailBoxItem *mail=[[MailBoxItem alloc]init];
        [mail setIdx:[object objectForKey:@"id"]];
        [mail setType:[object objectForKey:@"type"]];
        NSDictionary *Date =[object objectForKey:@"date"];
        [mail setDate:[Date objectForKey:@"date"]];
        [mail setTitle:[object objectForKey:@"title"]];
        [mail setText:[object objectForKey:@"text"]];
        
        [[MailBoxItem MailBox] AddMail:mail];
    }

    NSLog(@"ee");
}

@end
