//
//  TutorialSync.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "TutorialSync.h"
#import "TutorialItem.h"

@implementation TutorialSync
@synthesize TutorialItems;
@synthesize Delegate;
- (void)getTutorialInfo;
{
   
    
    TutorialItems=[[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/es/tutorial"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *DictData = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             NSString *version;
             NSString *error;
             for (NSDictionary *object in DictData) {
                version=[object objectForKey:@"id"];
             }
             NSString *TutorialVersion=[[NSUserDefaults standardUserDefaults] objectForKey:@"TutorialVersion"];
             NSString *TutorialVersionString=[NSString stringWithFormat:@"%@",TutorialVersion];
             if (TutorialVersion){
                 if (![TutorialVersionString isEqualToString:[NSString stringWithFormat:@"%@",version]]) {
                     [self getTutorialData];
                     [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"TutorialVersion"];
                 }else{
                     [self getTutorialDataFromFile];
                 }
             }else{
                 [self getTutorialData];
                 [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"TutorialVersion"];
             }
             
         }else{
             [self getTutorialDataFromFile];
         }
     }];
    
}
- (void)getTutorialData;
{
    TutorialItems=[[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/es/tutorial/1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             [self createAppSupport];
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
             NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
             NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataTutorial.json"];
             
             [data writeToFile:jsonPath atomically:YES];

             [self backWithData:data];
             
             
         }
     }];
    
}
- (void) createAppSupport{
    NSString *appSupportDir = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
    //If there isn't an App Support Directory yet ...
    if (![[NSFileManager defaultManager] fileExistsAtPath:appSupportDir isDirectory:NULL]) {
        NSError *error = nil;
        //Create one
        if (![[NSFileManager defaultManager] createDirectoryAtPath:appSupportDir withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            // *** OPTIONAL *** Mark the directory as excluded from iCloud backups
            NSURL *url = [NSURL fileURLWithPath:appSupportDir];
            if (![url setResourceValue:@YES
                                forKey:NSURLIsExcludedFromBackupKey
                                 error:&error])
            {
                NSLog(@"Error excluding %@ from backup %@", url.lastPathComponent, error.localizedDescription);
            }
            else {
                NSLog(@"Yay");
            }
        }
    }
}
- (void)getTutorialDataFromFile;
{
    TutorialItems=[[NSMutableArray alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
    NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataTutorial.json"];
    NSData *data=[NSData dataWithContentsOfFile:jsonPath];
    if (data.length > 0 ){
        [self backWithData:data];
    }
    
}
-(void) backWithData:(NSData*)data{
    NSDictionary *DictData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
    for (NSDictionary *object in DictData) {
        TutorialItem *ti=[[TutorialItem alloc]init];
        [ti setIdx:[object objectForKey:@"id"]];
        [ti setTutorial_id:[object objectForKey:@"tutorial_id"]];
        [ti setLang:[object objectForKey:@"lang"]];
        [ti setPosition:[object objectForKey:@"position"]];
        [ti setText:[object objectForKey:@"text"]];
        [ti setId_href:[object objectForKey:@"id_href"]];
        [ti setHref:[object objectForKey:@"href"]];
        [TutorialItems addObject:ti];
    }
    [Delegate PaintTutorial:TutorialItems];
}

@end
