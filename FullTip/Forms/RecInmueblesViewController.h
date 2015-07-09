//
//  RecInmueblesViewController.h
//  FullTip
//
//  Created by rafilla on 26/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@class ViewController;
@interface RecInmueblesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *Seg1;
@property (weak, nonatomic) IBOutlet UILabel *Seg2;
@property (weak, nonatomic) IBOutlet UILabel *Loc;
@property (weak, nonatomic) IBOutlet UILabel *Sli1;
@property (weak, nonatomic) IBOutlet UILabel *Sli2;
- (void) Paintdata:(NSString*)seg1 seg2:(NSString*)seg2 loc:(NSString*)loc seg3:(NSString*)seg3 sli1:(NSString*)sli1 sli2:(NSString*)sli2;

@property (strong,nonatomic) NSString *Val1;
@property (strong,nonatomic) NSString *Val2;
@property (strong,nonatomic) NSString *Val3;
@property (strong,nonatomic) NSString *Val4;
@property (strong,nonatomic) NSString *Val5;
@property (strong,nonatomic) NSString *Val6;
- (void)BackWithData;
@property (strong, nonatomic) ViewController *Delegate;
@end
