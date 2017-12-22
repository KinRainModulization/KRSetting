//
//  KRSettingView.h
//  KRSetting
//
//  Created by LX on 2017/12/21.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRSettingView : UITableView

@property (nonatomic, copy) void (^logoutBlock)(void);

@property (nonatomic, copy) void (^selectRowBlock)(NSIndexPath *indexPath);

@end
