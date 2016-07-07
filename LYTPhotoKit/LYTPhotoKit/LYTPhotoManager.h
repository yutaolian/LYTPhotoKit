//
//  LYTPhotoManager.h
//  yyg
//
//  Created by cosmistar on 7/6/16.
//  Copyright © 2016 cosmistar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYTPhotoModel.h"

typedef void(^PhotoArrayBlock)(NSArray *photoArray);

@interface LYTPhotoManager : NSObject

+ (LYTPhotoManager *)shareInstance;

- (BOOL)authorizationStatusAuthorized;


- (void)getAllPhotosArray:(PhotoArrayBlock)photoArray;

@end
