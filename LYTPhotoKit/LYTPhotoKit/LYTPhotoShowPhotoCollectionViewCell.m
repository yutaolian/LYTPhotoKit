//
//  LYTPhotoShowPhotoCollectionViewCell.m
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "LYTPhotoShowPhotoCollectionViewCell.h"
#import "LYTPhoto.h"

@interface LYTPhotoShowPhotoCollectionViewCell(){}

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIButton *deleteBtn;


@end

@implementation LYTPhotoShowPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}



- (void)initSubViews{
    
    
    CGFloat imageWidth = LYT_PhotoCellImageWidth;
    CGFloat iamgeHeight = LYT_PhotoCellImageHeight;
    
    
    CGFloat selectBtnWidth = LYT_PhotoCellSelectBtnWidth;
    CGFloat selectBtnHeight = LYT_PhotoCellSelectBtnHeight;
    
    [self addSubview:self.imageView];
    [self addSubview:self.deleteBtn];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|[_imageView(%f)]|",imageWidth] options:0 metrics:0 views:NSDictionaryOfVariableBindings(_imageView)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[_imageView(%f)]|",iamgeHeight] options:0 metrics:0 views:NSDictionaryOfVariableBindings(_imageView)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(>=0)-[_deleteBtn(%f)]|",selectBtnWidth] options:0 metrics:0 views:NSDictionaryOfVariableBindings(_deleteBtn)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[_deleteBtn(%f)]-(>=0)-|",selectBtnHeight] options:0 metrics:0 views:NSDictionaryOfVariableBindings(_deleteBtn)]];
    
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imageView;
}

- (UIButton *)deleteBtn{
    
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_deleteBtn setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
        [_deleteBtn setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateSelected];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (void)deleteBtnClick:(UIButton *)btn{
    if (_deleteBtnBlock) {
        _deleteBtnBlock(btn.tag);
    }
}

-(void)setPhotoModel:(LYTPhotoModel *)photoModel{
    
    _photoModel = photoModel;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self setData];
}

- (void)setData{
    _imageView.image = _photoModel.photo;
    _deleteBtn.tag = _index;
    if(_photoModel.deleteBtnFlag){
        _deleteBtn.alpha = 0;
    }else{
        _deleteBtn.alpha = 1;
    }
}



@end
