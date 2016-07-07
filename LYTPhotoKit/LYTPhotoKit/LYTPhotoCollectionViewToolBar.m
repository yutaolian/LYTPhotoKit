//
//  LYTPhotoCollectionViewToolBar.m
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "LYTPhotoCollectionViewToolBar.h"


@interface LYTPhotoCollectionViewToolBar(){}

@property(nonatomic,strong) UIButton *previewBtn;
@property(nonatomic,strong) UIButton *doneBtn;

@end

@implementation LYTPhotoCollectionViewToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews{

    [self addSubview:self.previewBtn];
    [self addSubview:self.doneBtn];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_previewBtn(<=100)]-(>=0)-[_doneBtn(<=100)]-(20)-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_previewBtn,_doneBtn)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_previewBtn(44)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_previewBtn)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_doneBtn(44)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_doneBtn)]];
    
}

- (UIButton *)previewBtn{
    
    if (!_previewBtn) {
        _previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _previewBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_previewBtn setTitle:@"预览" forState:UIControlStateNormal];
        [_previewBtn addTarget:self action:@selector(previewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        _previewBtn.backgroundColor = [UIColor redColor];
    }
    return _previewBtn;
}

- (UIButton *)doneBtn{
    
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        _doneBtn.backgroundColor = [UIColor yellowColor];
    }
    return _doneBtn;
}



- (void)previewBtnClick:(UIButton *)btn{

    NSLog(@"previewBtnClick");
    if (_previewBtnBlock) {
        _previewBtnBlock();
    }
}


- (void)doneBtnClick:(UIButton *)btn{
    
    NSLog(@"doneBtnClick");
    if (_doneBtnBlock) {
        _doneBtnBlock();
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
