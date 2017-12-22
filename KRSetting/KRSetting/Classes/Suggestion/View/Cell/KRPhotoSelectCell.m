//
//  KRPhotoSelectCell.m
//  KRSetting
//
//  Created by LX on 2017/12/22.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRPhotoSelectCell.h"

@interface KRPhotoSelectCell ()
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel *imageLabel;
@end

@implementation KRPhotoSelectCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.photoView];
        [self addSubview:self.deleteBtn];
        [self addSubview:self.imageLabel];
    }
    return self;
}

- (void)deleteButtonClick {
    self.deleteBlock(_cellTag);
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    if (imageURL == nil) {
        self.photoView.image = [UIImage imageNamed:@"comment_img_holder"];
    }
    else {
        self.photoView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    }
    self.deleteBtn.hidden = imageURL == nil;
    self.imageLabel.hidden = imageURL != nil;
}

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment_img_holder"]];
        _photoView.frame = CGRectMake(0, 8, self.width-8, self.height-8);
    }
    return _photoView;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"ic_photodel"] forState:UIControlStateNormal];
        _deleteBtn.frame = CGRectMake(self.width - 16, 0, 16, 16);
        [_deleteBtn addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UILabel *)imageLabel {
    if (!_imageLabel) {
        _imageLabel = [UILabel labelWithText:@"美照分享" textColor:RGB(210, 210, 210) fontSize:12];
        _imageLabel.centerX = (self.width-8)*0.5;
        _imageLabel.centerY = (self.height-8)*0.85;
    }
    return _imageLabel;
}
@end
