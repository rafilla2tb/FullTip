//
//  LeftLoginViewController.m
//  FullTip
//
//  Created by rafilla on 23/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "LeftUserViewController.h"
#import "GooglePlusLoginViewController.h"
#import "RegisterSync.h"
#import "LoginSync.h"
#import "LogOutSync.h"
@interface LeftUserViewController ()

@end

@implementation LeftUserViewController
@synthesize MenuArray,ImagesArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MenuArray=[[NSMutableArray alloc]initWithObjects:@"Home",@"Buzón",@"Mi Actividad",@"Calculadora de objetivos",@"Ranking", nil];
    ImagesArray=[[NSMutableArray alloc]initWithObjects:@"page1.png",@"page2.png",@"page3.png",@"page4.png",@"page1.png", nil];
    NSString *name=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    if (name) {
        _NameLabel.text=name;
    }
    NSString *img_href=[[NSUserDefaults standardUserDefaults] objectForKey:@"img_href"];
    if (img_href) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)GoToUser:(id)sender {
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MenuArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cella";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    for(UIView *view in cell.contentView.subviews){
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    NSString *imagen = [ImagesArray objectAtIndex:indexPath.row];
    NSString *Caption = [MenuArray objectAtIndex:indexPath.row];
    UIImageView *fondoCelda=[[UIImageView alloc]initWithFrame:CGRectMake(7,2,25,24)];
    fondoCelda.image=[UIImage imageNamed:imagen];
    [cell.contentView addSubview:fondoCelda];
    
    UILabel *CaptionButon = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, (_TableOptions.frame.size.width/1.3)-50, 30)];
    CaptionButon.text = [NSString stringWithFormat:@"%@",Caption];
    CaptionButon.textColor = [UIColor blackColor];
    CaptionButon.textAlignment=UITextAlignmentLeft;
    [CaptionButon setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    CaptionButon.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:CaptionButon];
    
    
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;
}
- (IBAction)LogOut:(id)sender {
    [self LogOut];
}
- (void)LogOut{
    
    
    NSString *IdUser=[[NSUserDefaults standardUserDefaults] objectForKey:@"IdUser"];
    NSString *access_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    
    NSString *postString = [NSString stringWithFormat:@"oauth-owner=user&access_token=%@",access_token];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/%@/logout?%@",IdUser,postString]];
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
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"IdUser"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"refresh_token"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"balance"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"img_href"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"country"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"name"];
        [[NSUserDefaults standardUserDefaults] setObject:Nil forKey:@"access_token"];
        [self LogOutOk];
    }else{
        
    }
    NSLog(@"ee");
}
- (void)LogOutOk{
    NSString *Mensaje = @"LogOut Ok";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FullTip"
                                                    message:Mensaje
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    [self.Delegate ShowLoginLateral:Nil];
    [self.view endEditing:YES];
    //[self.Delegate ReloadLeftPanels];
}

@end
