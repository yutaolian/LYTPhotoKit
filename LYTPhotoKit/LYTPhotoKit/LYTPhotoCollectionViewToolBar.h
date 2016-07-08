//
//  LYTPhotoCollectionViewToolBar.h
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PreviewBtnBlock)();
typedef void(^DoneBtnBlock)();

@interface LYTPhotoCollectionViewToolBar : UIView

@property(nonatomic,copy)  PreviewBtnBlock previewBtnBlock;
@property(nonatomic,copy)  DoneBtnBlock doneBtnBlock;

@property(nonatomic,copy) NSString *num;


@end
