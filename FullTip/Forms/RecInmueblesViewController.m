//
//  RecInmueblesViewController.m
//  FullTip
//
//  Created by rafilla on 26/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "RecInmueblesViewController.h"
#import "LeadSync.h"
@interface RecInmueblesViewController ()

@end

@implementation RecInmueblesViewController
@synthesize Val1,Val2,Val3,Val4,Val5,Val6;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) Paintdata:(NSString*)seg1 seg2:(NSString*)seg2 loc:(NSString*)loc seg3:(NSString*)seg3 sli1:(NSString*)sli1 sli2:(NSString*)sli2{
    _Seg1.text=seg1;
    _Seg2.text=seg2;
    
    _Loc.text=loc;
    _Sli1.text=sli1;
    _Sli2.text=sli2;
    
    Val1=[NSString stringWithString:seg1];
    Val2=[NSString stringWithString:seg2];
    Val3=[NSString stringWithString:loc];
    Val4=[NSString stringWithString:seg3];
    Val5=[NSString stringWithString:sli1];
    Val6=[NSString stringWithString:sli2];
    
}
- (IBAction)Sendlead:(id)sender {
    NSArray *arrayData=[NSArray arrayWithObjects:Val1,Val2,Val3,Val4,Val5,Val6, nil];
    LeadSync *lead=[[LeadSync alloc]init];
    [lead setDelegate:self];
    [lead postLeadInfo:arrayData withMail:@"ezeq1@ezeq1.es"];
}
- (void)BackWithData{
    [self.Delegate SendLeadOk];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
