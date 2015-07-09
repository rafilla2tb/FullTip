//
//  PageContentViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "PageContentViewController.h"
#import "WebImageOperations.h"
@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableString *fileName=[[NSMutableString alloc]initWithString:self.imageFile];
    [fileName replaceOccurrencesOfString:@"http://clientes.seresinertes.com/fulltip/public/" withString:@"" options: 0 range:NSMakeRange(0, [fileName length])];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
        
        [WebImageOperations processImageDataWithURLString:self.imageFile andBlock:^(NSData *imageData) {
            NSMutableString *fileName=[[NSMutableString alloc]initWithString:self.imageFile];
            [fileName replaceOccurrencesOfString:@"http://clientes.seresinertes.com/fulltip/public/" withString:@"" options: 0 range:NSMakeRange(0, [fileName length])];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:fileName];
            if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
                UIImage *image = [UIImage imageWithData:imageData];
                self.backgroundImageView.image = image;
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    // Generate the file path
                    
                    
                    
                    
                    // Save it into file system
                    [[NSFileManager defaultManager] createFileAtPath:dataPath contents:imageData  attributes:nil];
                    //[imageData writeToFile:dataPath atomically:YES];
                });
            }else{
                
            }
            
            
            
        }];

    }else{
        UIImage *image = [UIImage imageWithContentsOfFile:dataPath];
        self.backgroundImageView.image = image;
    }
    
    //self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
    // Pass along the URL to the image (or change it if you are loading there locally)
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
