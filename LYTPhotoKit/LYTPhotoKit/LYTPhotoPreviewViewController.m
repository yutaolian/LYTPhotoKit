//
//  LYTPhotoPreviewViewController.m
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "LYTPhotoPreviewViewController.h"
#import "LYTPhotoContentViewController.h"

#import "LYTPhoto.h"

/**
 *  图片预览
 */

@interface LYTPhotoPreviewViewController (){

    
}

@property(nonatomic,strong)UIPageViewController *pageViewController;
@property(nonatomic,strong) LYTPhotoContentViewController *photoContentViewController;

@end



@implementation LYTPhotoPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预览";
    
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initSubViews];
    
}
- (void)initSubViews{
    
    [self.view addSubview:self.pageViewController.view];
}


- (UIPageViewController *)pageViewController{

    if (!_pageViewController) {
        
        NSDictionary *options = [NSDictionary dictionaryWithObject:@(0) forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        
        //默认加载第一页
        LYTPhotoContentViewController *photoContentViewController = [self photoContentViewControllerAtIndex:0];
        
        NSArray *startViewControllers =@[photoContentViewController];
        
        [_pageViewController setViewControllers:startViewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
        
        _pageViewController.view.frame = CGRectMake(0, 44, LYT_kScreenWidth, LYT_kScreenHeight-64);
        
        [self addChildViewController:_pageViewController];
        
        [_pageViewController didMoveToParentViewController:self];
    }
    return _pageViewController;
}

- (LYTPhotoContentViewController *) photoContentViewControllerAtIndex:(NSInteger)index{
    
    if (_selectedArray.count == 0 || (index >= _selectedArray.count)) {
        
        return nil;
    }
    
    LYTPhotoContentViewController *photoContentViewController =[[LYTPhotoContentViewController alloc] init];
    
    photoContentViewController.photoModel = _selectedArray[index];
    photoContentViewController.pageIndex = index;
    return photoContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = ((LYTPhotoContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound || index == _selectedArray.count ) {
        return nil;
    }
    
    index--;
    return [self photoContentViewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = ((LYTPhotoContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [_selectedArray count]) {
        return  nil;
    }
    return [self photoContentViewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [_selectedArray count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
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
