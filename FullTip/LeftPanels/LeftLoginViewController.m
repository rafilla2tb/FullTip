//
//  LeftLoginViewController.m
//  FullTip
//
//  Created by rafilla on 23/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "LeftLoginViewController.h"
#import "GooglePlusLoginViewController.h"
#import "RegisterSync.h"
#import "LoginSync.h"
#import "iForgotSync.h"
#import "LoginGoogleSync.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>



typedef void(^AlertViewActionBlock)(void);

@interface LeftLoginViewController ()<GPPSignInDelegate,FBLoginViewDelegate>
@property (nonatomic, copy) void (^confirmActionBlock)(void);
@property (nonatomic, copy) void (^cancelActionBlock)(void);
@end

static NSString *const kPlaceholderUserName = @"<Name>";
static NSString *const kPlaceholderEmailAddress = @"<Email>";
static NSString *const kPlaceholderAvatarImageName = @"PlaceholderAvatar.png";

// Labels for the cells that have in-cell control elements.
static NSString *const kGetUserIDCellLabel = @"Get user ID";
static NSString *const kSingleSignOnCellLabel = @"Use Single Sign-On";
static NSString *const kButtonWidthCellLabel = @"Width";

// Labels for the cells that drill down to data pickers.
static NSString *const kColorSchemeCellLabel = @"Color scheme";
static NSString *const kStyleCellLabel = @"Style";
static NSString *const kAppActivitiesCellLabel = @"App activity types";

// Strings for Alert Views.
static NSString *const kSignOutAlertViewTitle = @"Warning";
static NSString *const kSignOutAlertViewMessage =
@"Modifying this element will sign you out of G+. Are you sure you wish to continue?";
static NSString *const kSignOutAlertCancelTitle = @"Cancel";
static NSString *const kSignOutAlertConfirmTitle = @"Continue";

// Accessibility Identifiers.
static NSString *const kCredentialsButtonAccessibilityIdentifier = @"Credentials";

@implementation LeftLoginViewController
@synthesize signIn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_LogView setAlpha:1];
    [_RegLog setAlpha:0];
    
    // Make sure the GPPSignInButton class is linked in because references from
    // xib file doesn't count.
    
    
    
    [GPPSignInButton class];
    
    signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;
    
    // Sync the current sign-in configurations to match the selected
    // app activities in the app activity picker.
  
    
    signIn.delegate = self;
    //self.credentialsButton.accessibilityIdentifier = kCredentialsButtonAccessibilityIdentifier;
    called=false;
    
    // Create Login View so that the app will be granted "status_update" permission.
    FBLoginView *loginview = [[FBLoginView alloc] init];
    loginview.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    loginview.frame = CGRectOffset(loginview.frame, 5, 85);
#ifdef __IPHONE_7_0
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        loginview.frame = CGRectOffset(loginview.frame, 5, 25);
    }
#endif
#endif
#endif
    loginview.delegate = self;
    
    [self.view addSubview:loginview];
    
    [loginview sizeToFit];
    
}

#pragma mark - FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // first get the buttons set for login mode

    
    // "Post Status" available when logged on and potentially when logged off.  Differentiate in the label.

}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    /*self.labelFirstName.text = [NSString stringWithFormat:@"Hello %@!", user.first_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    self.profilePic.profileID = user.objectID;
    self.loggedInUser = user;*/
    
    NSString *IdUser=[[NSUserDefaults standardUserDefaults] objectForKey:@"IdUser"];
    if (!IdUser) {
        if (called==FALSE) {
            NSString *identifier=[user objectForKey:@"id"];
            NSString *displayName=[user objectForKey:@"name"];
            NSString *userEmail=[user objectForKey:@"email"];
            NSString *userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", identifier];
            //NSString *url=[user objectForKey:@"link"];
            NSString *language=[user objectForKey:@"locale"];
            NSString *gender=[user objectForKey:@"gender"];
            
            [self PostLoginFb:identifier name:displayName email:userEmail avatar:userImageURL language:language gender:gender push_id:userEmail];
            called=TRUE;
        }
        
    }

   
    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    // test to see if we can use the share dialog built into the Facebook application
    FBLinkShareParams *p = [[FBLinkShareParams alloc] init];
    p.link = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
    BOOL canShareFB = [FBDialogs canPresentShareDialogWithParams:p];
    BOOL canShareiOS6 = [FBDialogs canPresentOSIntegratedShareDialogWithSession:nil];
    BOOL canShareFBPhoto = [FBDialogs canPresentShareDialogWithPhotos];
    
    
    
    // "Post Status" available when logged on and potentially when logged off.  Differentiate in the label.
    
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}

#pragma mark -


- (void)viewWillAppear:(BOOL)animated {
    //[self adoptUserSettings];
    [[GPPSignIn sharedInstance] trySilentAuthentication];
    //[self reportAuthStatus];
    //[self updateButtons];
    //[self.tableView reloadData];
    
    [super viewWillAppear:animated];
}

#pragma mark - GPPSignInDelegate

- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth
                   error:(NSError *)error {
    if (error) {
        //_signInAuthStatus.text =
        //[NSString stringWithFormat:@"Status: Authentication error: %@", error];
        return;
    }
    NSString *IdUser=[[NSUserDefaults standardUserDefaults] objectForKey:@"IdUser"];
    if (!IdUser) {
        if (called==FALSE) {
            GTLPlusPerson *person = [GPPSignIn sharedInstance].googlePlusUser;
            NSLog(@"Mail-->%@",[GPPSignIn sharedInstance].userEmail);
            NSLog(@"Nombre-->%@",person.displayName);
            NSString *identifier=person.identifier;
            NSString *displayName=person.displayName;
            NSString *userEmail=[GPPSignIn sharedInstance].userEmail;
            NSString *url=person.image.url;
            NSString *language=person.language;
            NSString *gender=person.gender;

            [self PostLoginGoogle:identifier name:displayName email:userEmail avatar:url language:language gender:gender push_id:userEmail];
            called=TRUE;
            person=Nil;
        }
        
        

    }
    
        //[self reportAuthStatus];
    //[self updateButtons];
}
- (void)PostLoginGoogle:(NSString*)ident name:(NSString*)name email:(NSString*)email avatar:(NSString*)avatar language:(NSString*)language gender:(NSString*)gender push_id:(NSString*)push_id;{
    
    //NSString *postString = [NSString stringWithFormat:@"oauth-owner=user&access_token=%@",access_token];
    NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/login-google"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"id=%@&name=%@&email=%@&avatar=%@&language=%@&gender=%@&push_id=%@",ident,name,email,avatar,language,gender,push_id];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             /*NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
              NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
              NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataLikes.json"];
              
              [data writeToFile:jsonPath atomically:YES];*/
             
             [self backWithData:data];
             
             
         }else{
             
         }
     }];
}

- (void)PostLoginFb:(NSString*)ident name:(NSString*)name email:(NSString*)email avatar:(NSString*)avatar language:(NSString*)language gender:(NSString*)gender push_id:(NSString*)push_id;{
    
    //NSString *postString = [NSString stringWithFormat:@"oauth-owner=user&access_token=%@",access_token];
    NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/login-facebook"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"id=%@&name=%@&email=%@&avatar=%@&language=%@&gender=%@&push_id=%@",ident,name,email,avatar,language,gender,push_id];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             /*NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
              NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
              NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataLikes.json"];
              
              [data writeToFile:jsonPath atomically:YES];*/
             
             [self backWithDataFb:data];
             
             
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
    NSString *IdUser=[DictData objectForKey:@"id"];
    [[NSUserDefaults standardUserDefaults] setObject:IdUser forKey:@"IdUser"];
    NSString *refresh_token=[DictData objectForKey:@"refresh_token"];
    [[NSUserDefaults standardUserDefaults] setObject:refresh_token forKey:@"refresh_token"];
    NSString *balance=[DictData objectForKey:@"balance"];
    [[NSUserDefaults standardUserDefaults] setObject:balance forKey:@"balance"];
    NSString *img_href=[DictData objectForKey:@"img_href"];
    [[NSUserDefaults standardUserDefaults] setObject:img_href forKey:@"img_href"];
    NSString *country=[DictData objectForKey:@"country"];
    [[NSUserDefaults standardUserDefaults] setObject:country forKey:@"country"];
    NSString *name=[DictData objectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
    NSString *access_token=[DictData objectForKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"access_token"];
    
    NSString *result=[DictData objectForKey:@"result"];
    if (![result isEqualToString:@"ko"]) {
        [self LogOk];
    }else{
        NSString *Mensaje = [DictData objectForKey:@"msg"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FullTip"
                                                        message:Mensaje
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}
-(void) backWithDataFb:(NSData*)data{
    NSDictionary *DictData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
    NSString *theXml = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"xml-->%@",theXml);
    //for (NSDictionary *object in DictData) {
    NSString *IdUser=[DictData objectForKey:@"id"];
    [[NSUserDefaults standardUserDefaults] setObject:IdUser forKey:@"IdUser"];
    NSString *refresh_token=[DictData objectForKey:@"refresh_token"];
    [[NSUserDefaults standardUserDefaults] setObject:refresh_token forKey:@"refresh_token"];
    NSString *balance=[DictData objectForKey:@"balance"];
    [[NSUserDefaults standardUserDefaults] setObject:balance forKey:@"balance"];
    NSString *img_href=[DictData objectForKey:@"img_href"];
    [[NSUserDefaults standardUserDefaults] setObject:img_href forKey:@"img_href"];
    NSString *country=[DictData objectForKey:@"country"];
    [[NSUserDefaults standardUserDefaults] setObject:country forKey:@"country"];
    NSString *name=[DictData objectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
    NSString *access_token=[DictData objectForKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"access_token"];
    
    NSString *result=[DictData objectForKey:@"result"];
    if (![result isEqualToString:@"ko"]) {
        [self LogOk];
    }else{
        NSString *Mensaje = [DictData objectForKey:@"msg"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FullTip"
                                                        message:Mensaje
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}
- (void)didDisconnectWithError:(NSError *)error {
    if (error) {
        //_signInAuthStatus.text =
        //[NSString stringWithFormat:@"Status: Failed to disconnect: %@", error];
    } else {
        //_signInAuthStatus.text =
        //[NSString stringWithFormat:@"Status: Disconnected"];
    }
    //[self refreshUserInfo];
    //[self updateButtons];
}

- (void)presentSignInViewController:(UIViewController *)viewController {
    [[self navigationController] pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ShowRegister:(id)sender {
    [_RegLog setAlpha:1];
    [_LogView setAlpha:0];
}
- (IBAction)ShowLog:(id)sender {
    [_RegLog setAlpha:0];
    [_LogView setAlpha:1];
}
- (IBAction)LoginAction:(id)sender {
    [self PostLoginWithMail:_LogMail.text withPassWord:_LogPass.text];
}
- (void)PostLoginWithMail:(NSString*)mail withPassWord:(NSString*)pass {
    
    [[NSUserDefaults standardUserDefaults] setObject:mail forKey:@"UserMail"];
    NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"email=%@&password=%@&client_id=fullTipApp&client_secret=pTwsJLDsqtUXfMThQNizRtkGB&type=app&pushid=rafael.santamaria@ezeq.es",mail,pass];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             /*NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
              NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
              NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataLikes.json"];
              
              [data writeToFile:jsonPath atomically:YES];*/
             //[[NSUserDefaults standardUserDefaults] setObject:mail forKey:@"Email"];
             [self backWithDataLogin:data];
             
             
         }else{
         }
     }];
}
- (void) backWithDataLogin:(NSData*)data{
    NSDictionary *DictData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
    NSString *theXml = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"xml-->%@",theXml);
    //for (NSDictionary *object in DictData) {
    NSString *IdUser=[DictData objectForKey:@"id"];
    [[NSUserDefaults standardUserDefaults] setObject:IdUser forKey:@"IdUser"];
    NSString *refresh_token=[DictData objectForKey:@"refresh_token"];
    [[NSUserDefaults standardUserDefaults] setObject:refresh_token forKey:@"refresh_token"];
    NSString *balance=[DictData objectForKey:@"balance"];
    [[NSUserDefaults standardUserDefaults] setObject:balance forKey:@"balance"];
    NSString *img_href=[DictData objectForKey:@"img_href"];
    [[NSUserDefaults standardUserDefaults] setObject:img_href forKey:@"img_href"];
    NSString *country=[DictData objectForKey:@"country"];
    [[NSUserDefaults standardUserDefaults] setObject:country forKey:@"country"];
    NSString *name=[DictData objectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
    NSString *access_token=[DictData objectForKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"access_token"];
    
    NSString *result=[DictData objectForKey:@"result"];
    if (![result isEqualToString:@"ko"]) {
        [self LogOk];
    }else{
        NSString *Mensaje = [DictData objectForKey:@"msg"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FullTip"
                                                        message:Mensaje
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    //}
    
    
    /*for (NSDictionary *object in DictData) {
     LikesItem *Like=[[LikesItem alloc]init];
     [Like setIdx:[object objectForKey:@"id"]];
     [Like setName:[object objectForKey:@"name"]];
     [Like setDescripcion:[object objectForKey:@"description"]];
     [Like setPosition:[object objectForKey:@"position"]];
     [Like setHref_cat:[object objectForKey:@"href_cat"]];
     [LikesItems addObject:Like];
     }
     //[Delegate PaintCategory:LikesItems];
     [Delegate setLikesArray:[NSArray arrayWithArray:LikesItems]];*/
    NSLog(@"ee");
}


- (IBAction)registerAction:(id)sender {
    [self PostRegisterWithMail:_MailReg.text withPassWord:_PassReg.text withRepeatPassword:_RepPassReg.text withPushId:_MailReg.text withName:_NameReg.text];
}

- (void)PostRegisterWithMail:(NSString*)mail withPassWord:(NSString*)pass withRepeatPassword:(NSString*)passRep withPushId:(NSString*)push withName:(NSString*)name{
    NSURL *url = [NSURL URLWithString:@"http://clientes.seresinertes.com/fulltip/public/api/v1/app/user/register"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"email=%@&password=%@&password_confirmation=%@&push_id=%@&name=%@",mail,pass,passRep,push,name];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             /*NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
              NSString *ApplicationSupportDirectory = [paths objectAtIndex:0];
              NSString *jsonPath = [ApplicationSupportDirectory stringByAppendingPathComponent:@"/dataLikes.json"];
              
              [data writeToFile:jsonPath atomically:YES];*/
             
             [self backWithDataRegister:data];
             
             
         }else{
         }
     }];
}

-(void) backWithDataRegister:(NSData*)data{
    NSDictionary *DictData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:NULL];
    NSString *theXml = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    //for (NSDictionary *object in DictData) {
    /*NSString *IdUser=[DictData objectForKey:@"id"];
     [[NSUserDefaults standardUserDefaults] setObject:IdUser forKey:@"IdUser"];
     NSString *refresh_token=[DictData objectForKey:@"refresh_token"];
     [[NSUserDefaults standardUserDefaults] setObject:refresh_token forKey:@"refresh_token"];
     NSString *balance=[DictData objectForKey:@"balance"];
     [[NSUserDefaults standardUserDefaults] setObject:balance forKey:@"balance"];
     NSString *img_href=[DictData objectForKey:@"img_href"];
     [[NSUserDefaults standardUserDefaults] setObject:img_href forKey:@"img_href"];
     NSString *country=[DictData objectForKey:@"country"];
     [[NSUserDefaults standardUserDefaults] setObject:country forKey:@"country"];
     NSString *name=[DictData objectForKey:@"name"];
     [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
     NSString *access_token=[DictData objectForKey:@"access_token"];
     [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"access_token"];*/
    
    NSString *result=[DictData objectForKey:@"result"];
    if (![result isEqualToString:@"ko"]) {
        [self RegOk];
    }else{
        NSString *Mensaje = [DictData objectForKey:@"msg"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FullTip"
                                                        message:Mensaje
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
}
- (void)LogOk{
    NSString *Mensaje = @"Log Ok";
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

- (void)RegOk{
    NSString *Mensaje = @"Register Ok";
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



- (IBAction)iForgot:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rellene su correo"
                                                    message:@" "
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Ok", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        UITextField *textfield =  [actionSheet textFieldAtIndex: 0];
        NSString *mail = [textfield text];
        if ((mail!=nil)&&(![mail isEqualToString:@""])) {
            iForgotSync *forgot=[[iForgotSync alloc]init];
            [forgot setDelegate:self];
            [forgot iForgotSend:mail];

        }else{
            
        }
    }else if (buttonIndex==0){
        
    }
}
- (void)ForgotOk{
    NSString *Mensaje = @"Se ha mandado un correo";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
