//
//  LYTPhotoModel.h
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYTPhotoModel : NSObject

//作为相片时的model

- (instancetype)initWithPhoto:(id)photo isSelected:(BOOL)selected andType:(NSInteger)type;

//照片
@property(nonatomic,strong) id photo;
//是否选中
@property (nonatomic, assign) BOOL isSelected;
//文件类型
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *timeLength;

@property(nonatomic,assign) BOOL deleteBtnFlag;


//作为相册时的model

//相册名称
@property(nonatomic,copy) NSString *albumName;
//相册数量
@property(nonatomic,assign) NSInteger count;

@end
