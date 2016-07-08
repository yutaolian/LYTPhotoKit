//
//  LYTPhotoCategoryListViewController.m
//  yyg
//
//  Created by cosmistar on 7/6/16.
//  Copyright © 2016 cosmistar. All rights reserved.
//

#import "LYTPhotoCategoryListViewController.h"
#import "LYTPhotoCollectionViewController.h"
#import "LYTPhoto.h"

/**
 *  图片组（图片文件夹）
 */
@interface LYTPhotoCategoryListViewController (){
    
    NSMutableArray *_photoCategoryArray;
}


@property(nonatomic,strong) UITableView *tableView;

@end

static NSString *MyID = @"PhotoCategoryListTableViewCell";


@implementation LYTPhotoCategoryListViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = LYT_DefaultBgColor;
    _photoCategoryArray = [NSMutableArray array];
    //设置右侧键
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
    if(_fromFlag){
        self.navigationItem.title = @"照片";
        [self.view addSubview:self.tableView];
    }else{
        self.navigationItem.title = @"选择照片";
    }
    
    [self initData];
    
}

- (void)dismissVC{
    
    
    NSLog(@"2234");
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LYT_kScreenWidth, LYT_kScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}


#pragma mark - Table view data source
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_photoCategoryArray count];
}
//创建cell时每次都会调用
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //0.static 静态局部变量，只会初始化一次

    //1.先去缓存池找，
    //设置标示 reuseIdentifier
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MyID];
    //2.缓存没有创建新的cell
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyID];
        
        NSLog(@"-------------%ld",indexPath.row);
    }
    //3.设置数据
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_photoCategoryArray[indexPath.row]];
    
    //NSLog(@"--%p--cell--%ld",cell,indexPath.row);
    
    return cell;
}

#pragma mark - Table view delegate
#pragma  行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LYTPhotoCollectionViewController *photoCollectionVC = [[LYTPhotoCollectionViewController alloc] init];
    [self.navigationController pushViewController:photoCollectionVC animated:YES];
}





- (void)initData{
    
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", YES];
    
    //    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld",NO];
    
    // option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:self.sortAscendingByModificationDate]];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"modificationDate" ascending:YES]];
    
    PHAssetCollectionSubtype smartAlbumSubtype = PHAssetCollectionSubtypeSmartAlbumUserLibrary | PHAssetCollectionSubtypeSmartAlbumRecentlyAdded | PHAssetCollectionSubtypeSmartAlbumVideos;
    // For iOS 9, We need to show ScreenShots Album && SelfPortraits Album
    if (LYT_iOS9Later) {
        smartAlbumSubtype = PHAssetCollectionSubtypeSmartAlbumUserLibrary | PHAssetCollectionSubtypeSmartAlbumRecentlyAdded | PHAssetCollectionSubtypeSmartAlbumScreenshots | PHAssetCollectionSubtypeSmartAlbumSelfPortraits | PHAssetCollectionSubtypeSmartAlbumVideos;
    }
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:smartAlbumSubtype options:nil];
    for (PHAssetCollection *collection in smartAlbums) {
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
        //if (fetchResult.count < 1)
        //  continue;
        
        //        if (fetchResult.count < 1) continue;
        //        [_photoCategoryArray addObject:collection.localizedTitle];
        if (fetchResult.count < 1) continue;
        if ([collection.localizedTitle containsString:@"Deleted"] || [collection.localizedTitle isEqualToString:@"最近删除"]) continue;
        if ([collection.localizedTitle isEqualToString:@"Camera Roll"] || [collection.localizedTitle isEqualToString:@"相机胶卷"] || [collection.localizedTitle isEqualToString:@"所有照片"] || [collection.localizedTitle isEqualToString:@"All Photos"]) {
            [_photoCategoryArray insertObject:collection.localizedTitle atIndex:0];
        } else {
            [_photoCategoryArray addObject:collection.localizedTitle];
        }
        
    }
    
    PHFetchResult *albums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular | PHAssetCollectionSubtypeAlbumSyncedAlbum options:nil];
    for (PHAssetCollection *collection in albums) {
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
        // if (fetchResult.count < 1)
        //   continue;
        
        if ([collection.localizedTitle isEqualToString:@"My Photo Stream"] || [collection.localizedTitle isEqualToString:@"我的照片流"]) {
            if (_photoCategoryArray.count) {
                [_photoCategoryArray insertObject:collection.localizedTitle atIndex:1];
            } else {
                [_photoCategoryArray addObject:collection.localizedTitle];
            }
        } else {
            [_photoCategoryArray addObject:collection.localizedTitle];
        }
        
        
    }
    
    [_tableView reloadData];
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
