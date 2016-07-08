//
//  LYTPhotoViewController.h
//  yyg
//
//  Created by cosmistar on 7/6/16.
//  Copyright © 2016 cosmistar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTPhotoNavigationController.h"

typedef void(^ChooseDoneBlock)(NSArray *selectedArray,NSArray *allPhotoArray);

@interface LYTPhotoViewController : LYTPhotoNavigationController

@property(nonatomic,copy) ChooseDoneBlock chooseDoneBlock;
@property(nonatomic,strong) NSArray *updateAllPhotoArray;

- (instancetype)initWithAllPhotos:(NSArray *)photoArray andSelectedPhotoArray:(NSArray *)selectedArray;

@end
