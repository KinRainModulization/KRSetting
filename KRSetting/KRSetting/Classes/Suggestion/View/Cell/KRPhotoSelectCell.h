//
//  KRPhotoSelectCell.h
//  KRSetting
//
//  Created by LX on 2017/12/22.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRPhotoSelectCell : UICollectionViewCell

@property (nonatomic, copy) void (^deleteBlock)(NSInteger cellTag);

@property (nonatomic, assign) NSInteger cellTag;

@property (nonatomic, copy) NSString *imageURL;

@end
