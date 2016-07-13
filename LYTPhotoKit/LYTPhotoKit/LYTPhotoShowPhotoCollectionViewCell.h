//
//  LYTPhotoShowPhotoCollectionViewCell.h
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTPhotoModel.h"



typedef void(^DeleteBtnBlock)(NSInteger index);

@interface LYTPhotoShowPhotoCollectionViewCell : UICollectionViewCell

@property(nonatomic,copy) DeleteBtnBlock deleteBtnBlock;
@property(nonatomic,strong) LYTPhotoModel *photoModel;
@property(nonatomic,assign) NSInteger index;

@end
