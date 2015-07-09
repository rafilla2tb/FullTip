//
//  InmueblesViewController.h
//  FullTip
//
//  Created by rafilla on 24/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@class ViewController;
@interface InmueblesViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,UINavigationControllerDelegate>




@property (strong, nonatomic) ViewController *Delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *MainScroll;
@property (weak, nonatomic) IBOutlet UILabel *Label1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Segemented1;
@property (weak, nonatomic) IBOutlet UILabel *Label2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Segmented2;
@property (weak, nonatomic) IBOutlet UILabel *Label3;
@property (weak, nonatomic) IBOutlet UIPickerView *LocPicker;
@property (weak, nonatomic) IBOutlet UIButton *OkButton;
@property (weak, nonatomic) IBOutlet UILabel *LocLabel;
@property (weak, nonatomic) IBOutlet UILabel *Label4;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Segmented3;
@property (weak, nonatomic) IBOutlet UILabel *Label5;
@property (weak, nonatomic) IBOutlet UISlider *Slider1;
@property (weak, nonatomic) IBOutlet UILabel *Label6;
@property (weak, nonatomic) IBOutlet UILabel *LabelWin;
@property (weak, nonatomic) IBOutlet UISlider *SliderWin;
@property (weak, nonatomic) IBOutlet UIButton *FinishButton;


@end
