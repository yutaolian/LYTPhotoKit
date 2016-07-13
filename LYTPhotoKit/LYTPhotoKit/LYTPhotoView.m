//
//  LYTPhotoView.m
//  LYTPhotoKit
//
//  Created by lyt on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "LYTPhotoView.h"
#import "LYTPhoto.h"
#import "LYTPhotoShowPhotoCollectionViewCell.h"
#import "LYTPhotoPreviewViewController.h"

@interface LYTPhotoView(){
    
    NSMutableArray *_selectedPhotoArray;
    NSArray *_oldPhotoArray;
    BOOL _addFlag;
    NSArray *_resultArray;
    NSMutableArray *_tempAllPhotoArray;
}

@property(nonatomic,strong) LYTPhotoModel *addPhotoModel;


@end

static NSString *const collectionIndentifier = @"LYTPhotoViewCell";

@implementation LYTPhotoView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        self.dataSource = self;
        self.delegate = self;
    
        _tempAllPhotoArray = [NSMutableArray array];
        _selectedPhotoArray = [NSMutableArray array];
        _addFlag = YES;
        [_selectedPhotoArray addObject:self.addPhotoModel];
        
        
        [self registerClass:[LYTPhotoShowPhotoCollectionViewCell class] forCellWithReuseIdentifier:collectionIndentifier];
    }
    return self;
}


- (LYTPhotoModel *)addPhotoModel{
    if (!_addPhotoModel) {
        UIImage *image = [UIImage  imageNamedFromMyBundle:@"add_btn"];
        _addPhotoModel = [[LYTPhotoModel alloc] initWithPhoto:image isSelected:NO andType:0];
        _addPhotoModel.deleteBtnFlag = YES;
    }
    return _addPhotoModel;
}


#pragma mark - <UICollectionViewDataSource>
#pragma mark 组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark 数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_selectedPhotoArray count];
    
}
#pragma mark cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LYTPhotoShowPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIndentifier forIndexPath:indexPath];
    LYTPhotoModel *photoModel = _selectedPhotoArray[indexPath.row];
    cell.index = indexPath.row;
    cell.photoModel = photoModel;
    
    cell.deleteBtnBlock = ^(NSInteger index){
        [self performBatchUpdates:^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            [self deleteItemsAtIndexPaths:@[indexPath]];
            
            LYTPhotoModel *deletePhoto =_selectedPhotoArray[index];
            for (int i = 0; i < [_tempAllPhotoArray count]; i++) {
                LYTPhotoModel *photoModel = _tempAllPhotoArray[i];
                if (deletePhoto.index == photoModel.index) {
                    photoModel.isSelected = NO;
                }
            }
            [_selectedPhotoArray removeObjectAtIndex:index];
        } completion:^(BOOL finished) {
            if (!_addFlag) {
                [_selectedPhotoArray addObject:self.addPhotoModel];
                _addFlag = YES;
            }
            
            [self formatResultArray:_selectedPhotoArray];
            [self reloadData];
           
        }];
    };
    return cell;
}


#pragma mark - <UICollectionViewDelegate>
#pragma mark 设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(LYT_UserShowPhotoCellWidth,LYT_UserShowPhotoCellHeight);
    
}

#pragma mark 设置cell相对于外界的距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(LYT_CellToTop, LYT_CellToLeft , LYT_CellToRight,LYT_CellToBottom);
    
}
#pragma mark 左右距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return LYT_CellToCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"indexpath---%@",indexPath);
    
    if (indexPath.row == ([_selectedPhotoArray count] - 1)) {
        LYTPhotoViewController *photoVC = [[LYTPhotoViewController alloc] initWithAllPhotos:_tempAllPhotoArray andSelectedPhotoArray:_resultArray];
        photoVC.chooseDoneBlock = ^(NSArray *selectedArray,NSArray *allPhotoArray){
            [_tempAllPhotoArray removeAllObjects];
            [_tempAllPhotoArray addObjectsFromArray:allPhotoArray];
            [_selectedPhotoArray removeAllObjects];
            [_selectedPhotoArray addObjectsFromArray:selectedArray];
         
            if ([selectedArray count] < LYT_kMaxPhotoCount) {
                [_selectedPhotoArray addObject:self.addPhotoModel];
                _addFlag = YES;
            }else{
                _addFlag = NO;
            }
          
            [self formatResultArray:_selectedPhotoArray];
            [self reloadData];
            
        };
        [_vc presentViewController:photoVC animated:YES completion:nil];
        
    }else{
        
        LYTPhotoPreviewViewController *photoPreviewVC = [[LYTPhotoPreviewViewController alloc] init];
        
        [self formatResultArray:_selectedPhotoArray];
        photoPreviewVC.selectedArray = _resultArray;
        [_vc.navigationController pushViewController:photoPreviewVC animated:YES];
    }
}

- (void)formatResultArray:(NSArray *)photoArray{
    if (_resultPhotoBlock) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:photoArray];
        if (_addFlag) {
            [tempArray removeLastObject];
        }
        NSMutableArray *resultArray = [NSMutableArray array];
        for (int i = 0; i < [tempArray count]; i++) {
            LYTPhotoModel *photoModel = tempArray[i];
            [resultArray addObject:photoModel.photo];
        }
        _resultArray = resultArray;
        _resultPhotoBlock(_resultArray);
        _heightOfPhotosBlock([self heightOfResultArray:_resultArray]);
    }
}

- (CGFloat)heightOfResultArray:(NSArray *)resultArray{
    NSInteger count = [resultArray count];
    if (count >= 4) {
        return LYT_UserShowPhotoCellHeight * 2 + LYT_CellToTop + LYT_CellToBottom;
    }
    return LYT_UserShowPhotoCellHeight + LYT_CellToTop + LYT_CellToBottom;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
