//
//  ViewController.m
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "ViewController.h"
#import "LYTPhotoView.h"

@interface ViewController (){
    
    NSArray *_imageArray;
}

@property(nonatomic,strong) LYTPhotoView *photoView;
@property(nonatomic,strong) UITableView  *tableView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.photoView];
 
    [self.view addSubview:self.tableView];
}


- (LYTPhotoView *)photoView{
    
    if (!_photoView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _photoView = [[LYTPhotoView alloc] initWithFrame: CGRectMake(0, 20, 368, 300) collectionViewLayout:flowLayout];
        _photoView.vc = self;
        _photoView.resultPhotoBlock = ^(NSArray *resultArray){
            
            _imageArray = resultArray;
            [_tableView reloadData];
            //获得已经选中的图片
            NSLog(@"result array---%ld",[resultArray count]);
            for (int i = 0; i < [resultArray count]; i++) {
                NSLog(@"image--%@",resultArray[i]);
            }

        };
    }
    return _photoView;
}
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, 368, 200) style:UITableViewStylePlain];
    
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
    return [_imageArray count];
}
//创建cell时每次都会调用
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //0.static 静态局部变量，只会初始化一次
    static NSString *MyID = @"TableViewCell";
    
    //1.先去缓存池找，
    //设置标示 reuseIdentifier
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MyID];
    //2.缓存没有创建新的cell
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyID];
        
        NSLog(@"-------------%ld",indexPath.row);
    }
    //3.设置数据
//    cell.textLabel.text = [NSString stringWithFormat:@"num---%ld",indexPath.row];
    
    cell.imageView.image = _imageArray[indexPath.row];
    
    //NSLog(@"--%p--cell--%ld",cell,indexPath.row);
    
    return cell;
}
#pragma  行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
