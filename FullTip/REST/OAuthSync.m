//
//  TutorialSync.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "OAuthSync.h"


@implementation OAuthSync
@synthesize LikesItems;

- (void)PostOAuth

{
   
    
    LikesItems=[[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/oauth_token"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *refresh_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"refresh_token"];
    [[NSUserDefaults standardUserDefaults] setObject:refresh_token forKey:@"refresh_token"];
    NSString *postString = [NSString stringWithFormat:@"refresh_token=%@&client_id=fullTipApp&client_secret=pTwsJLDsqtUXfMThQNizRtkGB&grant_type=refresh_token",refresh_token];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             /*NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
             NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
             NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataLikes.json"];
             
             [data writeToFile:jsonPath atomically:YES];*/
             
             [self backWithData:data];
             
             
         }else{
             [self getCategoryDataFromFile];
         }
     }];
}


- (void)getCategoryDataFromFile;
{
    LikesItems=[[NSMutableArray alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
    NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataLikes.json"];
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
    //for (NSDictionary *object in DictData) {
    
    
    
    NSString *result=[DictData objectForKey:@"result"];
    if (![result isEqualToString:@"ko"]) {
        NSString *refresh_token=[DictData objectForKey:@"refresh_token"];
        [[NSUserDefaults standardUserDefaults] setObject:refresh_token forKey:@"refresh_token"];
        NSString *access_token=[DictData objectForKey:@"access_token"];
        [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"access_token"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"IdUser"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"refresh_token"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"balance"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"img_href"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"country"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"name"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"access_token"];
    }
    //}
    
    
    /*for (NSDictionary *object in DictData) {
        LikesItem *Like=[[LikesItem alloc]init];
        [Like setIdx:[object objectForKey:@"id"]];
        [Like setName:[object objectForKey:@"name"]];
        [Like setDescripcion:[object objectForKey:@"description"]];
        [Like setPosition:[object objectForKey:@"position"]];
        [Like setHref_cat:[object objectForKey:@"href_cat"]];
        [LikesItems addObject:Like];
    }
    //[Delegate PaintCategory:LikesItems];
    [Delegate setLikesArray:[NSArray arrayWithArray:LikesItems]];*/
    NSLog(@"ee");
}

@end
