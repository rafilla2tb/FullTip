//
//  LeftLoginViewController.h
//  FullTip
//
//  Created by rafilla on 23/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@class ViewController;
@interface LeftUserViewController : UIViewController<UITableViewDelegate,UITableViewDataSource
>

@property (strong, nonatomic) ViewController *Delegate;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *HrefImage;
@property (weak, nonatomic) IBOutlet UITableView *TableOptions;


@property (nonatomic, strong) NSMutableArray *MenuArray;
@property (nonatomic, strong) NSMutableArray *ImagesArray;
- (IBAction)logOut:(id)sender;
- (IBAction)GoToUser:(id)sender;
- (void)LogOutOk;
@end
