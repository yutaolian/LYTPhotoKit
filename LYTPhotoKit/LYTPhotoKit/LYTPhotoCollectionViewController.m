//
//  LYTPhotoCollectionViewController.m
//  yyg
//
//  Created by cosmistar on 7/6/16.
//  Copyright © 2016 cosmistar. All rights reserved.
//

#import "LYTPhotoCollectionViewController.h"
#import "LYTPhotoCategoryListViewController.h"
#import "LYTPhotoPreviewViewController.h"
#import "LYTPhotoCollectionViewCell.h"
#import "LYTPhotoCollectionViewToolBar.h"
#import "LYTPhoto.h"
/**
 *  图片显示（collection）
 */

@interface LYTPhotoCollectionViewController (){

    NSMutableArray *_allPhotoArray;
    NSMutableArray*_queueArray;
    
    NSInteger _selectedNum;
}

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) LYTPhotoCollectionViewToolBar *toolBar;


@end
static NSString *const BrowseImageIndentifier = @"BrowseImageCollectionViewIndentifier";


@implementation LYTPhotoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LYT_DefaultBgColor;
    _allPhotoArray = [NSMutableArray array];
    _queueArray = [NSMutableArray array];
    self.title = @"所有照片";
    //设置右侧键
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
    
    [self initSubViews];
    if ([_updateAllPhotoArray count]) {
        [_allPhotoArray removeAllObjects];
        [_allPhotoArray addObjectsFromArray:_updateAllPhotoArray];
        _toolBar.num = [NSString stringWithFormat:@"%ld",[_selectedPhotoArray count]];
        [self.collectionView reloadData];
    }else{
        [self initData];
    }
}
- (void)initSubViews{
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.toolBar];
}

- (void)initData{
    
    [[LYTPhotoManager shareInstance] getAllPhotosArray:^(NSArray *photoArray) {
        
        [_allPhotoArray removeAllObjects];
        [_allPhotoArray addObjectsFromArray:photoArray];
        [_collectionView reloadData];
    }];
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, LYT_kScreenWidth, LYT_kScreenHeight-44) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = LYT_DefaultBgColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[LYTPhotoCollectionViewCell class] forCellWithReuseIdentifier:BrowseImageIndentifier];
    }
    return _collectionView;
}

- (LYTPhotoCollectionViewToolBar *)toolBar{
    
    if (!_toolBar) {
        _toolBar = [[LYTPhotoCollectionViewToolBar alloc] init];
        _toolBar.frame = CGRectMake(0, LYT_kScreenHeight-44, LYT_kScreenWidth, 44);
        _toolBar.backgroundColor = [UIColor lightGrayColor];
        __weak LYTPhotoCollectionViewController *weakSelf = self;
        _toolBar.previewBtnBlock = ^(){
        
            [weakSelf pushToPhotoPreviewViewController];
        };
        _toolBar.doneBtnBlock = ^(){
        
            [weakSelf choosePhotoDone];
        };
    }
    return _toolBar;
}


#pragma mark - <UICollectionViewDataSource>
#pragma mark 组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark 数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_allPhotoArray count];
    
}
#pragma mark cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LYTPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BrowseImageIndentifier forIndexPath:indexPath];
    cell.index = indexPath.row;
    LYTPhotoModel *photoModel = _allPhotoArray[indexPath.row];
    photoModel.index = indexPath.row;
    cell.photoModel = photoModel;
    __weak LYTPhotoCollectionViewController *weakSelf = self;
    cell.selectedBtnBlock = ^(NSInteger index,BOOL selectedFlag){
            if (selectedFlag) {
                [_queueArray addObject:@(index)];
            }
            [weakSelf updateSelectedStatusAtIndex:index andSelectedFlag:selectedFlag];
    };
    return cell;
    
}

- (void)updateSelectedStatusAtIndex:(NSInteger)index andSelectedFlag:(BOOL)selectedFlag{
    if (selectedFlag) {
        LYTPhotoModel *photoModel = _allPhotoArray[index];
        photoModel.isSelected = YES;
    }else{
        LYTPhotoModel *photoModel = _allPhotoArray[index];
        if (photoModel.index == index) {
            photoModel.isSelected = NO;
        }
    }
    [self verdictSelectedNumAtIndex:index];

}

- (void)verdictSelectedNumAtIndex:(NSInteger )index{
    _selectedNum = [self getAllSelectedPhoto].count;
    if (_selectedNum > LYT_kMaxPhotoCount) {
        LYTPhotoModel *photoModel = _allPhotoArray[index];
        photoModel.isSelected = NO;
        [self showAlertWithTitle:[NSString stringWithFormat:@"你最多只能选择%zd张照片",LYT_kMaxPhotoCount]];
        [_collectionView reloadData];
    }else{
        _toolBar.num = [NSString stringWithFormat:@"%ld",_selectedNum];
    }
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

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//}

#pragma mark - 去图片预览页
- (void)pushToPhotoPreviewViewController{

    LYTPhotoPreviewViewController *photoPreviewVC = [[LYTPhotoPreviewViewController alloc] init];
    photoPreviewVC.selectedArray = [self getAllSelectedPhoto];
    [self.navigationController pushViewController:photoPreviewVC animated:YES];
}

- (void)choosePhotoDone{
    
    if (_selectedPhotoBlock) {
        _selectedPhotoBlock([self getAllSelectedPhoto],_allPhotoArray);
    }

    [self dismissVC];
}
- (NSArray *)getAllSelectedPhoto{
    NSMutableArray *selectedPhotoArray = [NSMutableArray array];
    for (int i = 0; i < [_allPhotoArray count]; i++) {
        LYTPhotoModel *photoModel = _allPhotoArray[i];
        if (photoModel.isSelected) {
            [selectedPhotoArray addObject:photoModel];
        }
    }
    return selectedPhotoArray;
}

- (void)dismissVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showPhotosList{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)showAlertWithTitle:(NSString *)title {
    if (LYT_iOS8Later) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil] show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
