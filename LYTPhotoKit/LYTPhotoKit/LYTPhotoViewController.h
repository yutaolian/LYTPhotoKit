//
//  LYTPhotoViewController.h
//  yyg
//
//  Created by cosmistar on 7/6/16.
//  Copyright © 2016 cosmistar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTPhotoNavigationController.h"

typedef void(^ChooseDoneBlock)(NSArray *photoArray);

@interface LYTPhotoViewController : LYTPhotoNavigationController

@property(nonatomic,copy) ChooseDoneBlock chooseDoneBlock;

//- (instancetype)initWithHasSelectedPhoto:(NSArray *)photoArray;

@end
