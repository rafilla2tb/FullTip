//
//  MyCollectionViewCell.m
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import "LikesCollectionViewCell.h"

@implementation LikesCollectionViewCell
- (IBAction)catPress:(id)sender {
    UIButton *but=(UIButton*)sender;
    [self.Delegate CellPress:but.tag];
}

@end
