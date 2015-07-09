//
//  TutorialSync.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "LoginSync.h"


@implementation LoginSync
@synthesize LikesItems;
@synthesize Delegate;
- (void)PostLoginWithMail:(NSString*)mail withPassWord:(NSString*)pass {
   
    [[NSUserDefaults standardUserDefaults] setObject:mail forKey:@"UserMail"];
    LikesItems=[[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"email=%@&password=%@&client_id=fullTipApp&client_secret=pTwsJLDsqtUXfMThQNizRtkGB&type=app&pushid=rafael.santamaria@ezeq.es",mail,pass];
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
             //[[NSUserDefaults standardUserDefaults] setObject:mail forKey:@"Email"];
             [self backWithData:data];
             
             
         }else{
         }
     }];
}
- (void) backWithData:(NSData*)data{
    NSDictionary *DictData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
    NSString *theXml = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"xml-->%@",theXml);
    //for (NSDictionary *object in DictData) {
        NSString *IdUser=[DictData objectForKey:@"id"];
        [[NSUserDefaults standardUserDefaults] setObject:IdUser forKey:@"IdUser"];
        NSString *refresh_token=[DictData objectForKey:@"refresh_token"];
        [[NSUserDefaults standardUserDefaults] setObject:refresh_token forKey:@"refresh_token"];
        NSString *balance=[DictData objectForKey:@"balance"];
        [[NSUserDefaults standardUserDefaults] setObject:balance forKey:@"balance"];
        NSString *img_href=[DictData objectForKey:@"img_href"];
        [[NSUserDefaults standardUserDefaults] setObject:img_href forKey:@"img_href"];
        NSString *country=[DictData objectForKey:@"country"];
        [[NSUserDefaults standardUserDefaults] setObject:country forKey:@"country"];
        NSString *name=[DictData objectForKey:@"name"];
        [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
        NSString *access_token=[DictData objectForKey:@"access_token"];
        [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"access_token"];
    
    NSString *result=[DictData objectForKey:@"result"];
    if (![result isEqualToString:@"ko"]) {
        [self.Delegate LogOk];
    }else{
        NSString *Mensaje = [DictData objectForKey:@"msg"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FullTip"
                                                        message:Mensaje
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
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
