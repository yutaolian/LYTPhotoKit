//
//  LYTPhotoCollectionViewCell.m
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "LYTPhotoCollectionViewCell.h"
#import "LYTPhoto.h"
@interface LYTPhotoCollectionViewCell(){}


@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIButton *selectBtn;

@end

@implementation LYTPhotoCollectionViewCell

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
    [self addSubview:self.selectBtn];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|[_imageView(%f)]|",imageWidth] options:0 metrics:0 views:NSDictionaryOfVariableBindings(_imageView)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[_imageView(%f)]|",iamgeHeight] options:0 metrics:0 views:NSDictionaryOfVariableBindings(_imageView)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(>=0)-[_selectBtn(%f)]|",selectBtnWidth] options:0 metrics:0 views:NSDictionaryOfVariableBindings(_selectBtn)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[_selectBtn(%f)]-(>=0)-|",selectBtnHeight] options:0 metrics:0 views:NSDictionaryOfVariableBindings(_selectBtn)]];
    
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imageView;
}

- (UIButton *)selectBtn{
    
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_selectBtn setImage:[UIImage imageNamed:@"photo_def_photoPickerVc"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"photo_sel_photoPickerVc"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}


- (void)selectBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (_selectedBtnBlock) {
        _selectedBtnBlock(btn.tag,btn.selected);
    }
}

- (void)setPhotoModel:(LYTPhotoModel *)photoModel{
    _photoModel = photoModel;
    _selectBtn.tag = _index;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self setData];
}

- (void)setData{

    _imageView.image = _photoModel.photo;
    _selectBtn.selected = _photoModel.isSelected;
}



@end
