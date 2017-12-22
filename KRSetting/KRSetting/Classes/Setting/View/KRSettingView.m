//
//  KRSettingView.m
//  KRSetting
//
//  Created by LX on 2017/12/21.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRSettingView.h"
#import "KRSettingCell.h"

@interface KRSettingView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSources;

@property (nonatomic, strong) UIButton *logoutBtn;

@end

@implementation KRSettingView

static NSString * kSettingArrowCellIdentifier = @"kSettingArrowCellIdentifier";
static NSString * kSettingTitleCellIdentifier = @"kSettingTitleCellIdentifier";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[KRSettingCell class] forCellReuseIdentifier:kSettingArrowCellIdentifier];
        [self registerClass:[KRSettingCell class] forCellReuseIdentifier:kSettingTitleCellIdentifier];
        self.backgroundColor = GLOBAL_BACKGROUND_COLOR;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)logoutButtonClick {
    self.logoutBlock();
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectRowBlock) {
        self.selectRowBlock(indexPath);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionData = self.dataSources[section];
    return sectionData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isTitleCell = indexPath.section == 0 && indexPath.row == 0;
    KRSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:isTitleCell ? kSettingTitleCellIdentifier : kSettingArrowCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *sectionData = self.dataSources[indexPath.section];
    NSString *itemData = sectionData[indexPath.row];
    cell.title = itemData;
    cell.subTitle = isTitleCell ? @"1365456465" : @"";
    return cell;
}

- (UIView *)tableFooterView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return self.logoutBtn;
    }
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 4 ? 50 : 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIButton *)logoutBtn {
    if (!_logoutBtn) {
        _logoutBtn = [UIButton buttonWithTitle:@"退出登录" fontSize:14 titleColor:RGB(255, 0, 54) target:self action:@selector(logoutButtonClick)];
        _logoutBtn.backgroundColor = [UIColor whiteColor];
    }
    return _logoutBtn;
}

- (NSArray *)dataSources {
    if (!_dataSources) {
        _dataSources = @[
                         @[@"联系客服",@"建议反馈"],
                         @[@"关于我们",@"用户协议"],
                         @[@"商家合作"],
                         @[@"点赞/吐槽APP"],
                         @[],
                         ];
    }
    return _dataSources;
}
@end
