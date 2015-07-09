//
//  CollectionViewController.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCollectionViewCell.h"
#import "ViewController.h"
#import "CategoryItem.h"
@class ViewController;
@interface HomeCollectionViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate>{
    ViewController *Delegate;
}
@property (strong, nonatomic) NSMutableArray *Categories;
@property (strong, nonatomic) ViewController *Delegate;
-(void)CellPress:(int)tag;
@end
