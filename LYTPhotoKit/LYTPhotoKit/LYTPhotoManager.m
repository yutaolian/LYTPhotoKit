//
//  LYTPhotoManager.m
//  yyg
//
//  Created by cosmistar on 7/6/16.
//  Copyright © 2016 cosmistar. All rights reserved.
//

#import "LYTPhotoManager.h"
#import "LYTPhoto.h"
#import "LYTPhotoModel.h"

@implementation LYTPhotoManager


+ (LYTPhotoManager *)shareInstance{
    static LYTPhotoManager *_shareInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _shareInstance = [[LYTPhotoManager alloc] init];
    });
    return _shareInstance;
}


#pragma mark - Return YES if Authorized 返回YES如果得到了授权
- (BOOL)authorizationStatusAuthorized {
    if (LYT_iOS8Later) {
        //iOS>=8
        if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) return YES;
    } else {
        //iOS7
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) return YES;
    }
    return NO;
}

- (void)getAllPhotosArray:(PhotoArrayBlock)photoArray{

    
    NSMutableArray *allPhotoArray = [NSMutableArray array];
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    BOOL allowPickingVideo = NO;
    BOOL allowPickingImage = YES;
    
    if (allowPickingImage){
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    }
    if (allowPickingVideo){
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld",PHAssetMediaTypeVideo];
    }
    // option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:self.sortAscendingByModificationDate]];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"modificationDate" ascending:NO]];
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    for (PHAssetCollection *collection in smartAlbums) {
        if ([collection.localizedTitle isEqualToString:@"Camera Roll"] || [collection.localizedTitle isEqualToString:@"相机胶卷"] ||  [collection.localizedTitle isEqualToString:@"所有照片"] || [collection.localizedTitle isEqualToString:@"All Photos"]) {
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
            
            NSLog(@"collection.localizedTitle---%@",collection.localizedTitle);
            NSLog(@"%@----",fetchResult);
            
            [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                PHAsset *asset = (PHAsset *)obj;
                CGSize imageSize;
                imageSize = CGSizeMake(800, 1000);
                NSLog(@"uiimage---%ld",idx);
                
                PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
                option.resizeMode = PHImageRequestOptionsResizeModeFast;
                
                PHImageRequestID pHImageRequestID = [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    
                    LYTPhotoModel  *photoModel = [[LYTPhotoModel alloc] initWithPhoto:result isSelected:NO andType:PHAssetMediaTypeImage];
                    
                    [allPhotoArray addObject:photoModel];
                }];
                
                NSLog(@"pHImageRequestID---%d",pHImageRequestID);
                
//                UIEdgeInsets
                
            }];
            
            photoArray(allPhotoArray);
            break;
        }
    }
}

@end
