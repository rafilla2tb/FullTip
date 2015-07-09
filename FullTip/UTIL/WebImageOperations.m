//
//  WebImageOperations.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "WebImageOperations.h"
#import <QuartzCore/QuartzCore.h>

@implementation WebImageOperations


+ (void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_queue_t downloadQueue = dispatch_queue_create("com.fulltip.processsmagequeue", NULL);
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(callerQueue, ^{
            processImage(imageData);
        });
    });
    //dispatch_release(downloadQueue);
}

@end