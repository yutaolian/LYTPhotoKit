//
//  LYTPhoto.h
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#ifndef LYTPhoto_h
#define LYTPhoto_h


#endif /* LYTPhoto_h */

#import "LYTPhotoViewController.h"
#import "LYTPhotoManager.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

//当前手机系统版本号
#define LYT_iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define LYT_iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define LYT_iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)

//获得的当前屏幕的宽度
#define LYT_kScreenWidth [UIScreen mainScreen].bounds.size.width
//获得的当前屏幕的高度
#define LYT_kScreenHeight [UIScreen mainScreen].bounds.size.height

//默认的vc背景颜色
#define LYT_DefaultBgColor [UIColor whiteColor]

//图片collection 页面展示图片的大小
#define LYT_PhotoCellImageWidth 80
#define LYT_PhotoCellImageHeight 80


//图片collection 右上角选择按钮的大小
#define LYT_PhotoCellSelectBtnWidth 30
#define LYT_PhotoCellSelectBtnHeight 30

#define LYT_kMaxPhotoCount 6



