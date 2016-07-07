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
}


@property(nonatomic,strong) UITableView *tableView;

@end

static NSString *MyID = @"PhotoCategoryListTableViewCell";


@implementation LYTPhotoCategoryListViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = LYT_DefaultBgColor;

    //设置右侧键
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消1" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
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
    return 10;
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
    cell.textLabel.text = [NSString stringWithFormat:@"num---%ld",indexPath.row];
    
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
    
    BOOL allowPickingVideo = YES;
    
    BOOL allowPickingImage = NO;
    
    if (allowPickingVideo){
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    }
    if (allowPickingImage){
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
                
                //                [_dataArray addObject:asset];
                
                CGSize imageSize;
                imageSize = CGSizeMake(200, 200);
                
                
                NSLog(@"uiimage---%ld",idx);
                
                PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
                option.resizeMode = PHImageRequestOptionsResizeModeFast;
                
                PHImageRequestID pHImageRequestID = [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    
                    //[_dataArray addObject:result];
                    
                    //[_collectionView reloadData];
                }];
                
                NSLog(@"pHImageRequestID---%d",pHImageRequestID);
                
            }];
            
            break;
        }
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
