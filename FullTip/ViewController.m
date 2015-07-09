//
//  ViewController.m
//  FullTip
//
//  Created by rafilla on 19/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "ViewController.h"
#import "REST/TutorialSync.h"
#import "ITEMS/TutorialItem.h"
#import "REST/CategoriasSync.h"
#import "ITEMS/CategoryItem.h"
#import "REST/LikesSync.h"
#import "ITEMS/LikesItem.h"
#import "LeftLoginViewController.h"
#import "REST/RegisterSync.h"
#import "REST/LoginSync.h"
#import "REST/OAuthSync.h"
#import "REST/DashBoardSync.h"
#import "DashBoardItem.h"
#import "MailBoxSync.h"
#import "MailBoxItem.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Create the data model
    menuOpen=FALSE;
    
    BOOL HideTutorial=[[NSUserDefaults standardUserDefaults] boolForKey:@"HideTutorial"];
    if (HideTutorial==FALSE) {
        TutorialSync *t=[[TutorialSync alloc]init];
        [t setDelegate:self];
        [t getTutorialInfo];
    }

    CategoriasSync *c=[[CategoriasSync alloc]init];
    [c setDelegate:self];
    [c getCategoryInfo];

    
    LikesSync *l=[[LikesSync alloc]init];
    [l setDelegate:self];
    [l getLikesInfo];
    
    DashBoardSync *d=[[DashBoardSync alloc]init];
    //[d setDelegate:self];
    [d getDashBoardInfo];

    
    
    MailBoxSync *mail=[[MailBoxSync alloc]init];
    //[d setDelegate:self];
    [mail getMailBoxInfo];
    
    /*OAuthSync *oauth=[[OAuthSync alloc]init];
    //[oauth setDelegate:self];
    [oauth PostOAuth];*/
    
    self.LeftPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftLoginViewController"];
    // Change the size of page view controller
    self.LeftPanel.Delegate=self;
    self.LeftPanel.view.frame = CGRectMake(-self.view.frame.size.width/1.3, 0, self.view.frame.size.width/1.3, self.view.frame.size.height );
    
    //[self addChildViewController:_LeftPanel];
    [self.view  addSubview:_LeftPanel.view];
    //[self.LeftPanel didMoveToParentViewController:self];
    [self.HideButton setAlpha:0];
    
    self.LeftUserPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftUserViewController"];
    // Change the size of page view controller
    self.LeftUserPanel.Delegate=self;
    self.LeftUserPanel.view.frame = CGRectMake(-self.view.frame.size.width/1.3, 0, self.view.frame.size.width/1.3, self.view.frame.size.height );
    [self.view  addSubview:_LeftUserPanel.view];


}
- (void) ReloadLeftPanels{
    if (self.LeftUserPanel) {
        [self.LeftUserPanel.view removeFromSuperview];
        self.LeftUserPanel=Nil;
    }
    if (self.LeftPanel) {
        [self.LeftPanel.view removeFromSuperview];
        self.LeftPanel=Nil;
    }
    self.LeftPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftLoginViewController"];
    // Change the size of page view controller
    self.LeftPanel.Delegate=self;
    self.LeftPanel.view.frame = CGRectMake(-self.view.frame.size.width/1.3, 0, self.view.frame.size.width/1.3, self.view.frame.size.height );
    
    //[self addChildViewController:_LeftPanel];
    [self.view  addSubview:_LeftPanel.view];
    //[self.LeftPanel didMoveToParentViewController:self];
    [self.HideButton setAlpha:0];
    
    self.LeftUserPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftUserViewController"];
    // Change the size of page view controller
    self.LeftUserPanel.Delegate=self;
    self.LeftUserPanel.view.frame = CGRectMake(-self.view.frame.size.width/1.3, 0, self.view.frame.size.width/1.3, self.view.frame.size.height );
    [self.view  addSubview:_LeftUserPanel.view];
}
- (IBAction)ShowLoginLateral:(id)sender {

    if (menuOpen==FALSE) {
        NSString *IdUser=[[NSUserDefaults standardUserDefaults] objectForKey:@"IdUser"];
        if (IdUser) {
            self.LeftPanel.view.frame = CGRectMake(-self.view.frame.size.width/1.3, 0, self.view.frame.size.width/1.3, self.view.frame.size.height );
            [UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 [self.view bringSubviewToFront:self.LeftUserPanel.view];
                                 self.LeftUserPanel.view.frame = CGRectMake(0, 0, self.view.frame.size.width/1.3, self.view.frame.size.height );
                                 
                             } completion:^(BOOL finished){
                                 [UIView animateWithDuration:1.0 delay: 1.0 options:UIViewAnimationOptionCurveEaseOut
                                                  animations:^{
                                                      menuOpen=TRUE;
                                                  }completion:nil];
                             }];
        }else{
            self.LeftUserPanel.view.frame = CGRectMake(-self.view.frame.size.width/1.3, 0, self.view.frame.size.width/1.3, self.view.frame.size.height );
            [UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 [self.view bringSubviewToFront:self.LeftPanel.view];
                                 self.LeftPanel.view.frame = CGRectMake(0, 0, self.view.frame.size.width/1.3, self.view.frame.size.height );
                                 
                             } completion:^(BOOL finished){
                                 [UIView animateWithDuration:1.0 delay: 1.0 options:UIViewAnimationOptionCurveEaseOut
                                                  animations:^{
                                                      menuOpen=TRUE;
                                                  }completion:nil];
                             }];
        }
        
    }else{
        NSString *IdUser=[[NSUserDefaults standardUserDefaults] objectForKey:@"IdUser"];
        if (IdUser) {
            [UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.LeftUserPanel.view.frame = CGRectMake(-self.view.frame.size.width/1.3, 0, self.view.frame.size.width/1.3, self.view.frame.size.height );
                                 self.LeftPanel.view.frame = CGRectMake(-self.view.frame.size.width/1.3, 0, self.view.frame.size.width/1.3, self.view.frame.size.height );
                             } completion:^(BOOL finished){
                                 [UIView animateWithDuration:1.0 delay: 1.0 options:UIViewAnimationOptionCurveEaseOut
                                                  animations:^{
                                                      menuOpen=FALSE;
                                                  }completion:nil];
                             }];
        }else{
            [UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.LeftPanel.view.frame = CGRectMake(-self.view.frame.size.width/1.3, 0, self.view.frame.size.width/1.3, self.view.frame.size.height );
                                 self.LeftUserPanel.view.frame = CGRectMake(-self.view.frame.size.width/1.3, 0, self.view.frame.size.width/1.3, self.view.frame.size.height );
                             } completion:^(BOOL finished){
                                 [UIView animateWithDuration:1.0 delay: 1.0 options:UIViewAnimationOptionCurveEaseOut
                                                  animations:^{
                                                      menuOpen=FALSE;
                                                  }completion:nil];
                             }];
        }
        
    }
    
}
- (void) PaintCategory:(NSArray*)arrayCategory{
     self.Home = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeCollectionViewController"];
    // Change the size of page view controller
    
    self.Home.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/1.3 );
    self.Home.Delegate=self;
    [self addChildViewController:_Home];
    [self.view addSubview:_Home.view];
    [self.Home didMoveToParentViewController:self];
    [self.Home setCategories:[[NSMutableArray alloc] initWithArray:arrayCategory]];
    [self.Home.collectionView reloadData];
    
    
    //DashBoardItem *dash= [DashBoardItem DashBoard];
    
    //NSLog(@"%@",dash.name);
    
    MailBoxItem *mail= [MailBoxItem MailBox];
    
    NSLog(@"%@",mail.Mails);
}

- (void) PaintTutorial:(NSArray*)arrayTutorial{
    [self.HideButton setAlpha:1];
    self.navigationController.navigationBarHidden=TRUE;
    NSMutableArray *pageTitles=[[NSMutableArray alloc]init];
    NSMutableArray *pageImages=[[NSMutableArray alloc]init];
    
    for (TutorialItem *ti in arrayTutorial) {
        [pageImages addObject:ti.href];
        [pageTitles addObject:ti.text];
    }
    
    _pageTitles = pageTitles;
    _pageImages = pageImages;
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}
- (void) PaintInmuebleForm {
  NSLog(@"Categoria-->%f",self.navigationController.navigationBar.frame.size.height);
    self.navigationController.navigationBarHidden=TRUE;
    self.FormInmueble = [self.storyboard instantiateViewControllerWithIdentifier:@"InmueblesViewController"];
    // Change the size of page view controller
    self.FormInmueble.Delegate=self;
    self.FormInmueble.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.FormInmueble.view.bounds = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.FormInmueble.view setClipsToBounds:FALSE];
    [self addChildViewController:_FormInmueble];
    [self.view addSubview:_FormInmueble.view];
    [self.FormInmueble didMoveToParentViewController:self];
    
    
}
- (void) PaintRecInmuebleForm:(NSString*)seg1 seg2:(NSString*)seg2 loc:(NSString*)loc seg3:(NSString*)seg3 sli1:(NSString*)sli1 sli2:(NSString*)sli2{
      self.RecFormInmueble = [self.storyboard instantiateViewControllerWithIdentifier:@"RecInmueblesViewController"];
    // Change the size of page view controller
    self.RecFormInmueble.Delegate=self;
    self.RecFormInmueble.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    //[self addChildViewController:_LeftPanel];
    [self.view addSubview:_RecFormInmueble.view];
    [self.RecFormInmueble Paintdata:seg1 seg2:seg2 loc:loc seg3:seg3 sli1:sli1 sli2:sli2];
    //[self.LeftPanel didMoveToParentViewController:self];
        
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) SendLeadOk {
    
    [self.RecFormInmueble.view removeFromSuperview];
    [self.FormInmueble.view removeFromSuperview];
     self.navigationController.navigationBarHidden=FALSE;
}

- (IBAction)startWalkthrough:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HideTutorial"];
    [UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.pageViewController.view.frame = CGRectMake(0, -self.view.frame.size.height , self.view.frame.size.width, self.view.frame.size.height - 30);
                         ((UIButton*)sender).alpha=0;
                         self.navigationController.navigationBarHidden=FALSE;
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0 delay: 1.0 options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                             
                                          }completion:nil];
                     }];
    
}
- (IBAction)ShowPopUp:(id)sender {
    self.navigationController.navigationBarHidden=TRUE;
    self.PopUpPanel = [self.storyboard instantiateViewControllerWithIdentifier:@"PopUpCategorias"];
    // Change the size of page view controller
    
    self.PopUpPanel.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height );
    
    //[self addChildViewController:_LeftPanel];
    [self.view addSubview:_PopUpPanel.view];
    self.PopUpPanel.Delegate=self;
    [_PopUpPanel setLikesArray:[NSArray arrayWithArray:self.LikesArray]];
    self.PopUpPanel.view.alpha=0;
    //[self.LeftPanel didMoveToParentViewController:self];
    [UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.PopUpPanel.view.alpha=1;
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0 delay: 1.0 options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{ }completion:nil];
                     }];

}
- (void) ClosePopUp {
    
    
    [UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.PopUpPanel.view.alpha=0;
                         self.navigationController.navigationBarHidden=FALSE;
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:0.3 delay: 1.0 options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              [self.PopUpPanel.view removeFromSuperview];
                                          }completion:nil];
                     }];
    
}
- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

@end
