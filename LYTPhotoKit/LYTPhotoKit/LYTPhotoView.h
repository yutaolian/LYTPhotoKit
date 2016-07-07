//
//  LYTPhotoView.h
//  LYTPhotoKit
//
//  Created by lyt on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ResultPhotoBlock)(NSArray *resultArray);

@interface LYTPhotoView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UIViewController *vc;


@property(nonatomic,copy) ResultPhotoBlock resultPhotoBlock;



@end
