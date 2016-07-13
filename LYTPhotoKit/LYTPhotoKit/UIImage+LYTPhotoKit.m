//
//  UIImage+LYTPhotoKit.m
//  LYTPhotoKit
//
//  Created by cosmistar on 7/13/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "UIImage+LYTPhotoKit.h"

@implementation UIImage (LYTPhotoKit)


+ (UIImage *)imageNamedFromMyBundle:(NSString *)name {
    UIImage *image = [UIImage imageNamed:[@"LYTPhotoKit.bundle" stringByAppendingPathComponent:name]];
    if (image) {
        return image;
    } else {
        image = [UIImage imageNamed:[@"Frameworks/LYTPhotoKit.framework/LYTPhotoKit.bundle" stringByAppendingPathComponent:name]];
        return image;
    }
}

@end
