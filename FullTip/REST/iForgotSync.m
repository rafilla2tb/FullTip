//
//  TutorialSync.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "iForgotSync.h"


@implementation iForgotSync
@synthesize Delegate,av;

- (void)iForgot

{
 
    /*av = [[UIAlertView alloc]initWithTitle:@"Rellene su correo" message:@"tt " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av textFieldAtIndex:0].delegate = self;
    [av show];*/

}
- (void)iForgotSend:(NSString*)mail{
   
    
    NSString *postString = [NSString stringWithFormat:@"email=%@",mail];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/remember?%@",postString]];
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
        
    }else{
        
    }
    [self.Delegate ForgotOk];
    NSLog(@"ee");
}

@end
