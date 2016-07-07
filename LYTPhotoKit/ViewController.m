//
//  ViewController.m
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "ViewController.h"
#import "LYTPhoto.h"
#import "LYTPhotoModel.h"

#import "LYTPhotoShowPhotoCollectionViewCell.h"

@interface ViewController (){

    NSMutableArray *_selectedPhotoArray;
    NSArray *_oldPhotoArray;
    BOOL _addFlag;
}

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) LYTPhotoModel *placeModel;

@end


static NSString *const LYT_PhotoKitCollectionViewCellIndentifier = @"PhotoKitCollectionViewCellIndentifier";



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _selectedPhotoArray = [NSMutableArray array];
    _addFlag = YES;
    [_selectedPhotoArray addObject:self.placeModel];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
}

- (LYTPhotoModel *)placeModel{
    if (!_placeModel) {
        UIImage *image = [UIImage imageNamed:@"add_btn"];
        _placeModel = [[LYTPhotoModel alloc] initWithPhoto:image isSelected:NO andType:0];
    }
    return _placeModel;
}


- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, 368, 300) collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = [UIColor grayColor];
        //注册cell
        [_collectionView registerClass:[LYTPhotoShowPhotoCollectionViewCell class] forCellWithReuseIdentifier:LYT_PhotoKitCollectionViewCellIndentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
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
    
    LYTPhotoShowPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYT_PhotoKitCollectionViewCellIndentifier forIndexPath:indexPath];
    LYTPhotoModel *photoModel = _selectedPhotoArray[indexPath.row];
    cell.index = indexPath.row;
    cell.photoModel = photoModel;
   
    cell.deleteBtnBlock = ^(NSInteger index){
        [_collectionView performBatchUpdates:^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
            [_selectedPhotoArray removeObjectAtIndex:index];
        } completion:^(BOOL finished) {
            if (!_addFlag) {
                [_selectedPhotoArray addObject:self.placeModel];
                _addFlag = YES;
            }
            [_collectionView reloadData];
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
                [_selectedPhotoArray addObject:self.placeModel];
                _addFlag = YES;
            }else{
                _addFlag = NO;
            }
            [_collectionView reloadData];
        };
        [self presentViewController:photoVC animated:YES completion:nil];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
