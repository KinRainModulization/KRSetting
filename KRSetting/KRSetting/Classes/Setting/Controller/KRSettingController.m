//
//  KRSettingController.m
//  KRSetting
//
//  Created by LX on 2017/12/21.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRSettingController.h"
#import "KRSettingView.h"
#import <LXProgressHUD.h>
#import "KRAboutController.h"
#import "KRSuggestionController.h"

@interface KRSettingController ()

@end

@implementation KRSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    KRSettingView *settingView = [[KRSettingView alloc] initWithFrame:self.view.bounds];
    WEAK_SELF
    settingView.selectRowBlock = ^(NSIndexPath *indexPath) {
        [weakSelf selectRow:indexPath];
    };
    settingView.logoutBlock = ^{
        [weakSelf logout];
    };
    [self.view addSubview:settingView];
}

- (void)selectRow:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self handleSelectHotline];
        }
        else if (indexPath.row == 1) {
            [self handleSelectSuggestion];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self handleSelectAbout];
        }
    }
}

- (void)handleSelectHotline {
    if([CTSIMSupportGetSIMStatus() isEqualToString:kCTSIMSupportSIMStatusNotInserted]) {
        [LXProgressHUD showMessage:@"您的电话无法通话" toView:self.view];
    }
    else {
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"13956290011"];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
}

- (void)handleSelectSuggestion {
    [self.navigationController pushViewController:[[KRSuggestionController alloc] init] animated:YES];
}

- (void)handleSelectAbout {
    [self.navigationController pushViewController:[[KRAboutController alloc] init] animated:YES];
}

- (void)logout {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定退出登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
