//
//  LYTPhotoCollectionViewController.h
//  yyg
//
//  Created by cosmistar on 7/6/16.
//  Copyright © 2016 cosmistar. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SelectedPhotoBlock)(NSArray *photoArray);

@interface LYTPhotoCollectionViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,copy) SelectedPhotoBlock selectedPhotoBlock;

@end
