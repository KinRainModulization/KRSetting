//
//  KRSettingCell.m
//  KRSetting
//
//  Created by LX on 2017/12/21.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRSettingCell.h"
#import <KRArrowIconRowView.h>

@interface KRSettingCell ()

@property (nonatomic, weak) KRArrowIconRowView *rowView;

@end

@implementation KRSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        KRArrowIconRowView *rowView = [KRArrowIconRowView rowViewWithSize:CGSizeZero title:@"11" subtitle:@" " iconName:nil hiddenArrow:[reuseIdentifier isEqualToString:@"kSettingArrowCellIdentifier"] ? NO : YES];
        _rowView = rowView;
        [self addSubview:rowView];
        [rowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = GRAY_LINE_COLOR;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.leading.equalTo(self).offset(12);
            make.trailing.equalTo(self).offset(-12);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _rowView.title = title;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    _rowView.subTitle = subTitle;
}

@end
