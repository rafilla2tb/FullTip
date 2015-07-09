//
//  ViewController.h
//  FullTip
//
//  Created by rafilla on 19/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import "HomeCollectionViewController.h"
#import "LeftLoginViewController.h"
#import "LeftUserViewController.h"
#import "PopUpCategoriasViewController.h"
#import "InmueblesViewController.h"
#import "RecInmueblesViewController.h"
@class HomeCollectionViewController;
@class InmueblesViewController;
@class PopUpCategoriasViewController;
@class LeftLoginViewController;
@class LeftUserViewController;
@class RecInmueblesViewController;
@interface ViewController :  UIViewController <UIPageViewControllerDataSource>{
    BOOL menuOpen;
}
@property (weak, nonatomic) IBOutlet UIButton *HideButton;

- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@property (strong, nonatomic) HomeCollectionViewController *Home;
@property (strong, nonatomic) LeftLoginViewController *LeftPanel;
@property (strong, nonatomic) LeftUserViewController *LeftUserPanel;
@property (strong, nonatomic) PopUpCategoriasViewController *PopUpPanel;
@property (strong, nonatomic) InmueblesViewController *FormInmueble;
@property (strong, nonatomic) RecInmueblesViewController *RecFormInmueble;
@property (strong, nonatomic) NSArray *LikesArray;
- (void) PaintTutorial:(NSArray*)arrayTutorial;
- (void) ClosePopUp;
- (void) PaintInmuebleForm;
- (void) PaintRecInmuebleForm:(NSString*)seg1 seg2:(NSString*)seg2 loc:(NSString*)loc seg3:(NSString*)seg3 sli1:(NSString*)sli1 sli2:(NSString*)sli2;
- (void) PaintCategory:(NSArray*)arrayCategory;
- (IBAction)ShowLoginLateral:(id)sender;
- (void) ReloadLeftPanels;
- (void) SendLeadOk;
@end

