//
//  InmueblesViewController.m
//  FullTip
//
//  Created by rafilla on 24/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "InmueblesViewController.h"

@interface InmueblesViewController (){
    NSArray *_pickerData;
}

@end

@implementation InmueblesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pickerData = @[@"Madrid", @"Bilbao", @"Santander", @"Coruña", @"Oviedo", @"Pamplona"];
    self.LocPicker.dataSource = self;
    self.LocPicker.delegate = self;
    /*CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGSize scrollableSize = CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, 100);
    [_MainScroll setContentSize:scrollableSize];*/
    
    [self ReloadToFirstLevel];
    
}
- (void) ReloadToFirstLevel{
    [_Label2 setAlpha:0];
    [_Label3 setAlpha:0];
    [_Label4 setAlpha:0];
    [_Label5 setAlpha:0];
    [_Label6 setAlpha:0];
    [_LabelWin setAlpha:0];
    [_LocLabel setAlpha:0];
    
    [_Segmented2 setAlpha:0];
    [_Segmented3 setAlpha:0];
    
    [_Slider1 setAlpha:0];
    [_SliderWin setAlpha:0];
    
    [_LocPicker setAlpha:0];
    
    [_FinishButton setAlpha:0];
    [_OkButton setAlpha:0];
    
    
}

- (void)LoadNextLevel:(int)level{
    
    [UIView animateWithDuration:0.1 animations:^{
        if (level==0) {
            [self ReloadToFirstLevel];
            [_Label2 setAlpha:1];
            [_Segmented2 setAlpha:1];
            [_Segmented3 setEnabled:YES];

        }else if (level==1) {
            [self ReloadToFirstLevel];
            [_Label2 setAlpha:1];
            [_Segmented2 setAlpha:1];
            [_Label3 setAlpha:1];
            [_LocPicker setAlpha:1];
            [_OkButton setAlpha:1];

        }else if (level==2) {
            [self ReloadToFirstLevel];
            [_Label2 setAlpha:1];
            [_Segmented2 setAlpha:1];
            [_Label3 setAlpha:1];
            [_LocPicker setAlpha:1];
            [_OkButton setAlpha:1];
            [_LocLabel setAlpha:1];
            [_Label4 setAlpha:1];
            [_Segmented3 setAlpha:1];
            [_Label5 setAlpha:1];
            [_Slider1 setAlpha:1];
            [_Label6 setAlpha:1];
            [_LabelWin setAlpha:1];
            [_SliderWin setAlpha:1];
            [_FinishButton setAlpha:1];
        }else if (level==3) {
            
        }else if (level==4) {
            
        }else if (level==5) {
            
        }else if (level==6) {
            
        }
    }]; 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (IBAction)PickerOkButton:(id)sender {
    [self LoadNextLevel:2];
    int row = [_LocPicker selectedRowInComponent:0];
    _LocLabel.text = [_pickerData objectAtIndex:row];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.1 animations:^{
        [_LocPicker setAlpha:0];
        [_OkButton setAlpha:0];
        
    }];

}
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _pickerData.count;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _pickerData[row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    // i use a UILabel instead of your **custom UIView** , you may add a tick in you custom view
    
    UILabel *testRow = view?(UILabel *)view:[[UILabel alloc] init] ;
    //testRow.font = [UIFont fontWithName:[testArray objectAtIndex:row] size:16];
    testRow.text = [_pickerData objectAtIndex:row];
    testRow.textAlignment=UITextAlignmentCenter;
    testRow.backgroundColor = [UIColor clearColor];
    
    if ( row == [pickerView selectedRowInComponent:0] )
    {
        testRow.backgroundColor = [UIColor lightGrayColor];
    }
    
    return testRow;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [_LocPicker reloadComponent:0];
}

- (IBAction)Segemented1ValueChanged:(UISegmentedControl *)sender {
    [self LoadNextLevel:sender.tag];
}
- (IBAction)Segemented2ValueChanged:(UISegmentedControl *)sender {
    [self LoadNextLevel:sender.tag];
    if (sender.selectedSegmentIndex>1) {
        [_Segmented3 setEnabled:NO];
    }else{
        [_Segmented3 setEnabled:YES];
    }
}
- (IBAction)Segemented3ValueChanged:(UISegmentedControl *)sender {
    [self LoadNextLevel:sender.tag];
}
- (IBAction)slider1valueChanged:(UISlider *)sender {
    //[self LoadNextLevel:sender.tag];
}
- (IBAction)SliderWin:(UISlider *)sender {
    _LabelWin.text=[NSString stringWithFormat:@"Podrías ganar hasta %f",sender.value*1.5];
}
- (IBAction)VerResultsAction:(id)sender {
    
    
    NSString *seg1= [_Segemented1 titleForSegmentAtIndex:_Segemented1.selectedSegmentIndex];
    NSString *seg2= [_Segmented2 titleForSegmentAtIndex:_Segmented2.selectedSegmentIndex];
    NSString *seg3= [_Segmented3 titleForSegmentAtIndex:_Segmented3.selectedSegmentIndex];
    NSString *Loc=_LocLabel.text;
    
    NSString *sli1= [NSString stringWithFormat:@"%f",_Slider1.value];
    NSString *sli2= [NSString stringWithFormat:@"%f",_SliderWin.value];
    
    
    [self.Delegate PaintRecInmuebleForm:seg1 seg2:seg2 loc:Loc seg3:seg3 sli1:sli1 sli2:sli2];
    
}


@end
