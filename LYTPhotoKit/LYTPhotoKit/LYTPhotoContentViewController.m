//
//  LYTPhotoContentViewController.m
//  LYTPhotoKit
//
//  Created by cosmistar on 7/8/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "LYTPhotoContentViewController.h"

@interface LYTPhotoContentViewController ()

@end

@implementation LYTPhotoContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(30, 0, LYT_kScreenWidth-60, LYT_kScreenHeight-60);
    imageView.image = _photoModel.photo;
    
    [self.view addSubview:imageView];
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
