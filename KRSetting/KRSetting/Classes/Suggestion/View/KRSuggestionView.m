//
//  KRSuggestionView.m
//  KRSetting
//
//  Created by LX on 2017/12/22.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRSuggestionView.h"
#import "KRPhotoSelectCell.h"

#define kImageWidth (SCREEN_WIDTH-24-20) / 3

@interface KRSuggestionView ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UITextView *suggestionTextView;

@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, strong) UICollectionView *photoCollectionView;

@end

@implementation KRSuggestionView

static NSString * kImageSelectCellIdentifier = @"kImageSelectCellIdentifier";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];
    UIView *contentView = [[UIView alloc] init];
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = RGB(245, 245, 245);
    
    [self addSubview:contentView];
    [contentView addSubview:bgView];
    [contentView addSubview:self.suggestionTextView];
    [contentView addSubview:self.placeholderLabel];
    [contentView addSubview:self.photoCollectionView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.equalTo(self).offset(12);
        make.trailing.equalTo(self).offset(-12);
    }];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(10);
        make.leading.trailing.equalTo(contentView);
        make.height.mas_equalTo(225);
    }];
    [_suggestionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView).insets(UIEdgeInsetsMake(8, 8, 8, 8));
    }];
    [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(15);
        make.leading.equalTo(bgView).offset(15);
    }];
    [_photoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).offset(14);
        make.leading.trailing.equalTo(contentView);
        make.height.mas_offset(kImageWidth);
    }];
}

#pragma mark - UICollectionViewDelegate / DataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _imageDataSoure.count) {
        self.showImagePickerBlock();
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageDataSoure.count < 3 ? self.imageDataSoure.count+1 : self.imageDataSoure.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KRPhotoSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageSelectCellIdentifier forIndexPath:indexPath];
    if (indexPath.row != _imageDataSoure.count) {
        cell.imageURL = _imageDataSoure[indexPath.row][@"uri"];
        cell.cellTag = indexPath.row;
        cell.deleteBlock = _deleteImageBlock;
    }
    else {
        cell.imageURL = nil;
    }
    return cell;
}

#pragma mark - UITextViewDelegate
- (void)setImageDataSoure:(NSMutableArray *)imageDataSoure {
    _imageDataSoure = imageDataSoure;
    [_photoCollectionView reloadData];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.placeholderLabel.hidden = YES;
    } else {
        self.placeholderLabel.hidden = NO;
    }
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [UILabel labelWithText:@"留下您的宝贵建议" textColor:FONT_COLOR_99 fontSize:14];
    }
    return _placeholderLabel;
}

- (UITextView *)suggestionTextView {
    if (!_suggestionTextView) {
        _suggestionTextView = [[UITextView alloc] init];
        _suggestionTextView.delegate = self;
        _suggestionTextView.backgroundColor = RGB(245, 245, 245);
        _suggestionTextView.font = [UIFont systemFontOfSize:14];
        _suggestionTextView.textColor = FONT_COLOR_33;
    }
    return _suggestionTextView;
}

- (UICollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kImageWidth, kImageWidth);
        layout.minimumLineSpacing = 9;
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _photoCollectionView.backgroundColor = [UIColor whiteColor];
        _photoCollectionView.showsHorizontalScrollIndicator = NO;
        _photoCollectionView.bounces = NO;
        _photoCollectionView.dataSource = self;
        _photoCollectionView.delegate = self;
        [_photoCollectionView registerClass:[KRPhotoSelectCell class] forCellWithReuseIdentifier:kImageSelectCellIdentifier];
    }
    return _photoCollectionView;
}

@end
