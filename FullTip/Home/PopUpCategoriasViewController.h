//
//  PopUpCategoriasViewController.h
//  FullTip
//
//  Created by rafilla on 23/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LikesCollectionViewCell.h"
#import "ViewController.h"
#import "PopUpCategoriasViewController.h"
@class PopUpCategoriasViewController;
@class ViewController;
@interface PopUpCategoriasViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *LikesCollection;
@property (strong, nonatomic) NSArray *LikesArray;
@property (strong, nonatomic) ViewController *Delegate;
@property (weak, nonatomic) IBOutlet UIView *ThankView;
@property (weak, nonatomic) IBOutlet UIView *LikesView;
@property (strong ,nonatomic) NSMutableArray *CategoriesSelected;
- (void)BackWithData;
@end
