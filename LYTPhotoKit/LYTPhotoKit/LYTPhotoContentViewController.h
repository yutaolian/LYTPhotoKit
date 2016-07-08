//
//  LYTPhotoContentViewController.h
//  LYTPhotoKit
//
//  Created by cosmistar on 7/8/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTPhoto.h"
@interface LYTPhotoContentViewController : UIViewController


@property(nonatomic,strong) LYTPhotoModel *photoModel;

@property(nonatomic,assign) NSInteger pageIndex;
@end
