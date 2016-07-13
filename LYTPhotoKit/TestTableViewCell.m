//
//  TestTableViewCell.m
//  LYTPhotoKit
//
//  Created by cosmistar on 7/13/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "TestTableViewCell.h"

@interface TestTableViewCell(){}


@property(nonatomic,strong) LYTPhotoView *photoView;

@end

@implementation TestTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor redColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.userInteractionEnabled = YES;
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews{

    [self addSubview:self.photoView];
}



- (LYTPhotoView *)photoView{
    
    if (!_photoView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _photoView = [[LYTPhotoView alloc] initWithFrame: CGRectMake(0, 20, 368, 300) collectionViewLayout:flowLayout];
        _photoView.vc = _vc;
       // __weak ViewController *weakSelf = self;
        
        _photoView.resultPhotoBlock = ^(NSArray *resultArray){
            //_imageArray = resultArray;
           // [weakSelf.tableView reloadData];
            //获得已经选中的图片
            NSLog(@"result array---%ld",[resultArray count]);
            for (int i = 0; i < [resultArray count]; i++) {
                NSLog(@"image--%@",resultArray[i]);
            }
            
        };
    }
    return _photoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
