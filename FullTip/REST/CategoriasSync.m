//
//  TutorialSync.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "CategoriasSync.h"
#import "CategoryItem.h"

@implementation CategoriasSync
@synthesize CategoryItems;
@synthesize Delegate;
- (void)getCategoryInfo;
{
   
    
    CategoryItems=[[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/es/category"];
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
             
             
         }else{
             [self getCategoryDataFromFile];
         }
     }];
}
- (void)getTutorialData;
{
    CategoryItems=[[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/es/category"];
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
- (void)getCategoryDataFromFile;
{
    CategoryItems=[[NSMutableArray alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
    NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataCategory.json"];
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
        CategoryItem *cat=[[CategoryItem alloc]init];
        [cat setIdx:[object objectForKey:@"id"]];
        [cat setName:[object objectForKey:@"name"]];
        [cat setDate_create:[object objectForKey:@"date_create"]];
        [cat setDate_init:[object objectForKey:@"date_init"]];
        [cat setDate_end:[object objectForKey:@"date_end"]];
        [cat setActive:[object objectForKey:@"active"]];
        [cat setShow:[object objectForKey:@"show"]];
        [cat setDescripcion:[object objectForKey:@"description"]];
        [cat setPosition:[object objectForKey:@"position"]];
        [CategoryItems addObject:cat];
    }
    [Delegate PaintCategory:CategoryItems];
    NSLog(@"ee");
}

@end
