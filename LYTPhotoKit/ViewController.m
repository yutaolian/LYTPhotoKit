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

#import "LYTPhotoView.h"

@interface ViewController (){
}

@property(nonatomic,strong) LYTPhotoView *photoView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.photoView];
    
}


- (LYTPhotoView *)photoView{
    
    if (!_photoView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _photoView = [[LYTPhotoView alloc] initWithFrame: CGRectMake(0, 120, 368, 200) collectionViewLayout:flowLayout];        
        _photoView.vc = self;
        
        _photoView.resultPhotoBlock = ^(NSArray *resultArray){
            //获得已经选中的图片
            NSLog(@"result array---%ld",[resultArray count]);
        };
    }
    return _photoView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
