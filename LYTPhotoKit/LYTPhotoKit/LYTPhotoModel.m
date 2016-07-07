//
//  LYTPhotoModel.m
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "LYTPhotoModel.h"

@implementation LYTPhotoModel


- (instancetype)initWithPhoto:(id)photo isSelected:(BOOL)selected andType:(NSInteger)type{
    if (self == [super init]) {
        
        _photo = photo;
        _isSelected = selected;
        _type = type;
    }
    return self;
}


@end
