//
//  KRAboutController.m
//  KRSetting
//
//  Created by LX on 2017/12/21.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRAboutController.h"

@interface KRAboutController ()

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation KRAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    self.versionLabel.text = [NSString stringWithFormat:@"%@ 版本",infoDictionary[@"CFBundleShortVersionString"]];
}

@end
