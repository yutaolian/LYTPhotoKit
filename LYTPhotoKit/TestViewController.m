//
//  TestViewController.m
//  LYTPhotoKit
//
//  Created by cosmistar on 7/13/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController (){}

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (void)initSubViews{
    
    
    [self.view addSubview:self.tableView];
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300,400) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor grayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [UIView new];
        
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
    static NSString *MyID = @"OrderCommentListTableViewCell";
    
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
