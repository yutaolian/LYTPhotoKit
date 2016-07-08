//
//  LYTPhotoCollectionViewToolBar.m
//  LYTPhotoKit
//
//  Created by cosmistar on 7/7/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "LYTPhotoCollectionViewToolBar.h"
#import "LYTPhoto.h"

@interface LYTPhotoCollectionViewToolBar(){}

@property(nonatomic,strong) UIButton *previewBtn;
@property(nonatomic,strong) UILabel *numLabel;
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
    [self addSubview:self.numLabel];
    [self addSubview:self.doneBtn];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_previewBtn(<=100)]-(>=0)-[_numLabel(20)]-[_doneBtn(<=100)]-(20)-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_previewBtn,_numLabel,_doneBtn)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_previewBtn(44)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_previewBtn)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_doneBtn(44)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_doneBtn)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_numLabel(20)]-(12)-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_numLabel)]];
    
}

- (UIButton *)previewBtn{
    
    if (!_previewBtn) {
        _previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _previewBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_previewBtn setTitle:@"预览" forState:UIControlStateNormal];
        [_previewBtn addTarget:self action:@selector(previewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_previewBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_previewBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        _previewBtn.enabled = NO;
//        _previewBtn.backgroundColor = [UIColor redColor];
    }
    return _previewBtn;
}

- (UIButton *)doneBtn{
    
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        _doneBtn.enabled = NO;
//        _doneBtn.backgroundColor = [UIColor yellowColor];
    }
    return _doneBtn;
}

- (UILabel *)numLabel{

    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _numLabel.backgroundColor = LYT_NumLableBgColor;
        _numLabel.textColor = LYT_NumFontColor;
        _numLabel.layer.cornerRadius = 10;
        _numLabel.font = [UIFont systemFontOfSize:13];
        _numLabel.clipsToBounds = YES;
        _numLabel.textAlignment = NSTextAlignmentCenter;
//        _numLabel.text = @"2";
    }
    return _numLabel;
}


- (void)setNum:(NSString *)num{
    _num = num;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self setData];
}

- (void)setData{
    
    if ([_num integerValue]) {
        _doneBtn.enabled = YES;
        _doneBtn.selected = YES;
        
        _previewBtn.enabled = YES;
        _previewBtn.selected = YES;
        _numLabel.hidden = NO;
        _numLabel.text = _num;
    }else{
        _numLabel.hidden = YES;
        _doneBtn.enabled = NO;
        _previewBtn.enabled = NO;
    }
    [self showOscillatoryAnimationWithLayer:_numLabel.layer];
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


- (void)showOscillatoryAnimationWithLayer:(CALayer *)layer{
    
    
    //    NSNumber *animationScale1 = type == TZOscillatoryAnimationToBigger ? @(1.15) : @(0.5);
    //    NSNumber *animationScale2 = type == TZOscillatoryAnimationToBigger ? @(0.92) : @(1.15);
    
    NSNumber *animationScale1 = @(1.25);
    NSNumber *animationScale2 = @(0.82);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
