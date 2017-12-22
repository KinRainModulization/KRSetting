//
//  KRSuggestionView.h
//  KRSetting
//
//  Created by LX on 2017/12/22.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRSuggestionView : UIView

@property (nonatomic, copy) void (^deleteImageBlock)(NSInteger index);

@property (nonatomic, copy) void (^showImagePickerBlock)(void);

@property (nonatomic, strong) NSMutableArray *imageDataSoure;

@end
