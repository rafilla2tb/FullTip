//
//  MyCollectionViewCell.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCollectionViewController.h"
@class HomeCollectionViewController;
@interface HomeCollectionViewCell : UICollectionViewCell{
    HomeCollectionViewController *Delegate;
}
@property (strong, nonatomic) IBOutlet UIButton *catButon;
@property (strong, nonatomic) HomeCollectionViewController *Delegate;
@end
