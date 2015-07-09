//
//  TutorialSync.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "LikesSync.h"
#import "LikesItem.h"

@implementation LikesSync
@synthesize LikesItems;
@synthesize Delegate;
@synthesize LikesDelegate;
- (void)getLikesInfo
{
   
    
    LikesItems=[[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/es/category/likes"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
             NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
             NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataLikes.json"];
             
             [data writeToFile:jsonPath atomically:YES];
             
             [self backWithData:data];
             
             
         }else{
             [self getCategoryDataFromFile];
         }
     }];
}

- (void)postLikesInfo:(NSArray*)categories
{
    
    NSString *IdUser=[[NSUserDefaults standardUserDefaults] objectForKey:@"IdUser"];
    if (!IdUser) {
        IdUser=@"0";
    }
    int x=0;
    for (NSString *s in categories) {
        NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/es/category/likes"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSString *postString = [NSString stringWithFormat:@"id_user=%@&id_cat=%@",IdUser,s];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];

        x++;
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 
                 if (x==categories.count-1) {
                     data.accessibilityValue=@"Last";
                 }else{
                     data.accessibilityValue=@"NoLast";
                 }
                 if (categories.count==1) {
                     data.accessibilityValue=@"Last";
                 }else{
                     data.accessibilityValue=@"NoLast";
                 }
                 
                 [self backWithPostData:data];
                 
                 
             }
         }];
    }
    
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
    for (NSDictionary *object in DictData) {
        LikesItem *Like=[[LikesItem alloc]init];
        [Like setIdx:[object objectForKey:@"id"]];
        [Like setName:[object objectForKey:@"name"]];
        [Like setDescripcion:[object objectForKey:@"description"]];
        [Like setPosition:[object objectForKey:@"position"]];
        [Like setHref_cat:[object objectForKey:@"href_cat"]];
        [LikesItems addObject:Like];
    }
    //[Delegate PaintCategory:LikesItems];
    [Delegate setLikesArray:[NSArray arrayWithArray:LikesItems]];
    NSLog(@"ee");
}
-(void) backWithPostData:(NSData*)data{
    NSDictionary *DictData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
    if ([data.accessibilityValue isEqualToString:@"Last"]) {
        NSLog(@"Last one");
        [LikesDelegate BackWithData];
    }
    /*for (NSDictionary *object in DictData) {
        LikesItem *Like=[[LikesItem alloc]init];
        [Like setIdx:[object objectForKey:@"id"]];
        [Like setName:[object objectForKey:@"name"]];
        [Like setDescripcion:[object objectForKey:@"description"]];
        [Like setPosition:[object objectForKey:@"position"]];
        [Like setHref_cat:[object objectForKey:@"href_cat"]];
        [LikesItems addObject:Like];
    }*/
    //[Delegate PaintCategory:LikesItems];
    //[Delegate setLikesArray:[NSArray arrayWithArray:LikesItems]];
    NSLog(@"ee");
}
@end
