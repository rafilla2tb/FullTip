//
//  TutorialSync.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "LoginGoogleSync.h"


@implementation LoginGoogleSync
@synthesize LikesItems;
@synthesize Delegate;
- (void)PostLoginGoogle:(NSString*)ident name:(NSString*)name email:(NSString*)email avatar:(NSString*)avatar language:(NSString*)language gender:(NSString*)gender push_id:(NSString*)push_id;
{
   
    //NSString *postString = [NSString stringWithFormat:@"oauth-owner=user&access_token=%@",access_token];
    NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/login-google"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"id=%@&name=%@&email=%@&avatar=%@&language=%@&gender=%@&push_id=%@",ident,name,email,avatar,language,gender,push_id];
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
}

@end
