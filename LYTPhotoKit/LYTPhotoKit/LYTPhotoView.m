//
//  LYTPhotoView.m
//  LYTPhotoKit
//
//  Created by lyt on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "LYTPhotoView.h"
#import "LYTPhoto.h"
#import "LYTPhotoModel.h"
#import "LYTPhotoShowPhotoCollectionViewCell.h"

@interface LYTPhotoView(){
    
    NSMutableArray *_selectedPhotoArray;
    NSArray *_oldPhotoArray;
    BOOL _addFlag;
    NSMutableArray *_resultArray;
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
    
        _selectedPhotoArray = [NSMutableArray array];
        _resultArray = [NSMutableArray array];
        _addFlag = YES;
        [_selectedPhotoArray addObject:self.addPhotoModel];
        
        
        [self registerClass:[LYTPhotoShowPhotoCollectionViewCell class] forCellWithReuseIdentifier:collectionIndentifier];
    }
    return self;
}


- (LYTPhotoModel *)addPhotoModel{
    if (!_addPhotoModel) {
        UIImage *image = [UIImage imageNamed:@"add_btn"];
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
    
    return CGSizeMake(80,80);
    
}

#pragma mark 设置cell相对于外界的距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(15, 15 , 15,15);
    
}
#pragma mark 左右距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == ([_selectedPhotoArray count] - 1)) {
        LYTPhotoViewController *photoVC = [[LYTPhotoViewController alloc] init];
        photoVC.chooseDoneBlock = ^(NSArray *photoArray){
            [_selectedPhotoArray removeAllObjects];
            [_selectedPhotoArray addObjectsFromArray:photoArray];
            if ([photoArray count] < LYT_kMaxPhotoCount) {
                [_selectedPhotoArray addObject:self.addPhotoModel];
                _addFlag = YES;
            }else{
                _addFlag = NO;
            }
          
            [self formatResultArray:_selectedPhotoArray];
            [self reloadData];
            
        };
        [_vc presentViewController:photoVC animated:YES completion:nil];
        
    }
}

- (void)formatResultArray:(NSArray *)photoArray{
    if (_resultPhotoBlock) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:photoArray];
        [tempArray removeLastObject];
        NSMutableArray *resultArray = [NSMutableArray array];
        for (int i = 0; i < [tempArray count]; i++) {
            LYTPhotoModel *photoModel = tempArray[i];
            [resultArray addObject:photoModel.photo];
        }
        _resultPhotoBlock(resultArray);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
