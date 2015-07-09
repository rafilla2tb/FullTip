//
//  TutorialItem.h
//  FullTip
//
//  Created by rafilla on 22/6/15.
//  Copyright (c) 2015 Ezeq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryItem : NSObject
@property (strong, nonatomic) NSString *idx;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *date_create;
@property (strong, nonatomic) NSString *date_init;
@property (strong, nonatomic) NSString *date_end;
@property (strong, nonatomic) NSString *active;
@property (strong, nonatomic) NSString *show;
@property (strong, nonatomic) NSString *descripcion;
@property (strong, nonatomic) NSString *position;

@end
