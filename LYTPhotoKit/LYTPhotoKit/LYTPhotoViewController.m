//
//  LYTPhotoViewController.m
//  yyg
//
//  Created by cosmistar on 7/6/16.
//  Copyright © 2016 cosmistar. All rights reserved.
//

#import "LYTPhotoViewController.h"
#import "LYTPhotoCategoryListViewController.h"
#import "LYTPhotoCollectionViewController.h"
#import "LYTPhotoManager.h"
#import "LYTPhoto.h"


@interface LYTPhotoViewController (){

    
}
@property(nonatomic,strong) UIView *tipView;

@end

@implementation LYTPhotoViewController


- (instancetype)init
{
    LYTPhotoCategoryListViewController *photoCategoryListVC = [[LYTPhotoCategoryListViewController alloc] init];
    
    self = [super initWithRootViewController:photoCategoryListVC];
    if (self) {
        BOOL authFlag = [[LYTPhotoManager shareInstance] authorizationStatusAuthorized];
        if (!authFlag) {
            
            photoCategoryListVC.fromFlag = NO;
            [self.view addSubview:self.tipView];
        }else{
            
            photoCategoryListVC.fromFlag = YES;
            [self pushToPhotoCollectionViewController];
        }
    }    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYT_DefaultBgColor;
}

- (void)pushToPhotoCollectionViewController{
    LYTPhotoCollectionViewController *photoCollectionVC = [[LYTPhotoCollectionViewController alloc] init];
    photoCollectionVC.selectedPhotoBlock = ^(NSArray *photoArray){
        if (_chooseDoneBlock) {
            _chooseDoneBlock(photoArray);
        }
    };
    [self pushViewController:photoCollectionVC animated:YES];
    
}

- (UIView *)tipView{
    
    if (!_tipView) {
        _tipView = [[UIView alloc]init];
        _tipView.frame = CGRectMake(0, 64, LYT_kScreenWidth, LYT_kScreenHeight);
        
        UILabel *tipLable = [[UILabel alloc] init];
        tipLable.frame = CGRectMake(8, 0, LYT_kScreenWidth- 16,  200);
        tipLable.textAlignment = NSTextAlignmentCenter;
        tipLable.numberOfLines = 0;
        tipLable.font = [UIFont systemFontOfSize:16];
        tipLable.textColor = [UIColor blackColor];
        NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
        if (!appName) {
            appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
        }
        tipLable.text = [NSString stringWithFormat:@"请在%@的\"设置-隐私-照片\"选项中，\r允许 - %@ - 访问你的手机相册。",[UIDevice currentDevice].model,appName];
        [_tipView addSubview:tipLable];
    }
    return _tipView;
}


//- (instancetype)initWithHasSelectedPhoto:(NSArray *)photoArray{
//
//    LYTPhotoCategoryListViewController *photoCategoryListVC = [[LYTPhotoCategoryListViewController alloc] init];
//    
//    self = [super initWithRootViewController:photoCategoryListVC];
//    return self;
//}

- (void)initSubViews{

    LYTPhotoCategoryListViewController *photoCategoryListVC = [[LYTPhotoCategoryListViewController alloc] init];
    [self.navigationController addChildViewController:photoCategoryListVC];
    LYTPhotoCollectionViewController *photoCollectionVC = [[LYTPhotoCollectionViewController alloc] init];
    [self.navigationController addChildViewController:photoCollectionVC];
    
    
    self.view = self.navigationController.childViewControllers[1].view;
    
    
}

- (void)dismissVC{
    [self dismissViewControllerAnimated:YES completion:nil];
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
