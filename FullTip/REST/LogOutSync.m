//
//  TutorialSync.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "LogOutSync.h"


@implementation LogOutSync
@synthesize Delegate;

- (void)LogOut{
   
    
    NSString *IdUser=[[NSUserDefaults standardUserDefaults] objectForKey:@"IdUser"];
    NSString *access_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    
    NSString *postString = [NSString stringWithFormat:@"oauth-owner=user&access_token=%@",access_token];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/%@/logout?%@",IdUser,postString]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             [self backWithData:data];
         }else{

         }
     }];
}
-(void) backWithData:(NSData*)data{
    NSDictionary *DictData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
    NSString *theXml = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"xml-->%@",theXml);
    //for (NSDictionary *object in DictData) {
    
    
    
    NSString *result=[DictData objectForKey:@"result"];
    if ([result isEqualToString:@"ok"]) {
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"IdUser"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"refresh_token"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"balance"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"img_href"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"country"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"name"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"access_token"];
        //[self.Delegate LogOutOk];
    }else{
        
    }
    NSLog(@"ee");
}

@end
