//
//  PopUpCategoriasViewController.m
//  FullTip
//
//  Created by rafilla on 23/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "PopUpCategoriasViewController.h"
#import "LikesSync.h"
static NSString * const reuseIdentifier = @"Cell";
@interface PopUpCategoriasViewController ()

@end

@implementation PopUpCategoriasViewController
@synthesize CategoriesSelected;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_ThankView setAlpha:0];
    CategoriesSelected=[[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)close:(id)sender {
    [self.Delegate ClosePopUp];
    /*[UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.view.alpha=0;
                         self.navigationController.navigationBarHidden=FALSE;
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0 delay: 1.0 options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{ }completion:nil];
                     }];*/
}
#pragma mark <UICollectionViewDataSource>
- (IBAction)SendInfo:(id)sender {
    LikesSync *l=[[LikesSync alloc]init];
    [l setLikesDelegate:self];
    [l postLikesInfo:CategoriesSelected];
    
}
- (void)BackWithData{
    [UIView animateWithDuration:0.3 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [_LikesView setAlpha:0];
                         [_ThankView setAlpha:1];
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0 delay: 1.0 options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{ }completion:nil];
                     }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return _LikesArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LikesCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LikeCell" forIndexPath:indexPath];
    
    UIImage *image;
    long row = [indexPath row];
    image = [UIImage imageNamed:@"page1.png"];
    //[myCell.catButon setImage:image forState:UIControlStateNormal];
    CategoryItem *item=_LikesArray[row];
    [myCell.catButon setTitle:[NSString stringWithFormat:@"%@",item.name] forState:UIControlStateNormal];
    [myCell.catButon.titleLabel setTextAlignment:NSTextAlignmentCenter];
    myCell.catButon.accessibilityValue=item.idx;
    //[myCell.catButon setTitle:@"e" forState:UIControlStateNormal] ;
    //myCell.catButon.tag=[indexPath row];
    //myCell.Delegate=self;
    [myCell.catButon addTarget:self action:@selector(SelectCategory:) forControlEvents:UIControlEventTouchUpInside];
    [[myCell contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    return myCell;
}
-(void)SelectCategory:(id)sender{
    UIButton *but=(UIButton*)sender;
    
    if (but.selected==TRUE) {
        but.selected=FALSE;
        [CategoriesSelected removeObject:but.accessibilityValue];
    }else{
        but.selected=TRUE;
        [CategoriesSelected addObject:but.accessibilityValue];
    }
    
}
@end
