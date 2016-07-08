//
//  LYTPhotoPreviewViewController.h
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTPhotoPreviewViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property(nonatomic,strong) NSArray *selectedArray;

@end
