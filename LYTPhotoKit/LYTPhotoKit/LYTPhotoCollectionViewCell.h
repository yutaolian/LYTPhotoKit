//
//  LYTPhotoCollectionViewCell.h
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTPhotoModel.h"


typedef void(^SelectedBtnBlock)(NSInteger index,BOOL selectedFlag);

@interface LYTPhotoCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) LYTPhotoModel *photoModel;
@property(nonatomic,copy) SelectedBtnBlock selectedBtnBlock;
@property(nonatomic,assign) NSInteger index;

@end
