//
//  TutorialSync.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "LeadSync.h"


@implementation LeadSync

@synthesize Delegate;


- (void)postLeadInfo:(NSArray*)data withMail:(NSString*)mail
{
    
    NSString *IdUser=[[NSUserDefaults standardUserDefaults] objectForKey:@"IdUser"];
    NSString *access_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSString *name=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
   
    NSMutableString *query=[[NSMutableString alloc]initWithString:@""];
    if (IdUser) {
        
        int x=0;
        for (NSString *s in data) {
            if (x==0) {
                [query appendString:s];
            }else{
                [query appendFormat:@"|%@",s];
            }
            x++;
        }
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/%@/referral",IdUser]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"access_token=%@&id_cat=1&id_user=%@&query=%@&email=%@&name=%@&oauth-owner=user",access_token,IdUser,query,mail,name];
    
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             [self backWithPostData:data];
         }
     }];
    
    
}

-(void) backWithPostData:(NSData*)data{
    NSDictionary *DictData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
    NSString *status=[DictData objectForKey:@"status"];
    if ([status isEqualToString:@"ok"]) {
        [self.Delegate BackWithData];
        NSString *Mensaje = @"Lead Enviado";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FullTip"
                                                        message:Mensaje
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }else{
        NSString *Mensaje = [DictData objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FullTip"
                                                        message:Mensaje
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [self.Delegate BackWithData];
    }
    
}
@end
