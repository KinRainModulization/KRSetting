//
//  KRSuggestionController.m
//  KRSetting
//
//  Created by LX on 2017/12/21.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRSuggestionController.h"
#import "KRSuggestionView.h"
#import "DMAssetGroupViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface KRSuggestionController ()<DMAssetGroupViewControllerDelegate>

@property (nonatomic, strong) KRSuggestionView *suggestionView;
@property (nonatomic, strong) DMAssetGroupViewController *assetGroupViewController;
@property (nonatomic, strong) void (^handler)(NSArray *assets);
@property (nonatomic, strong) NSMutableArray *selectImages;

@end

@implementation KRSuggestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"建议反馈";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"提交" withTitleColor:FONT_COLOR_C8 withTarget:self withAction:@selector(submitSuggestion)];
    KRSuggestionView *suggestionView = [[KRSuggestionView alloc] initWithFrame:self.view.bounds];
    WEAK_SELF
    suggestionView.deleteImageBlock = ^(NSInteger index) {
        [weakSelf deleteSelectImageWithIndex:index];
    };
    suggestionView.showImagePickerBlock = ^{
        [weakSelf showImagePicker];
    };
    _suggestionView = suggestionView;
    [self.view addSubview:suggestionView];
}

- (void)submitSuggestion {
    [self showImagePicker];
}

- (void)deleteSelectImageWithIndex:(NSInteger)index {
    [_selectImages removeObjectAtIndex:index];
    self.suggestionView.imageDataSoure = _selectImages;
}

- (void)showImagePicker {
    DMAssetGroupViewController *groupViewController = [[DMAssetGroupViewController alloc] initWithMaxCount:3];
    self.assetGroupViewController = groupViewController;
    [self showPickerWhenCompleted:^(NSArray *assets) {
        
        NSMutableArray *arrayOfAssets = [[NSMutableArray alloc] init];
        for (ALAsset *asset in assets) {
            [arrayOfAssets addObject:[self fileObjectFromAsset:asset]];
        }
        _selectImages = arrayOfAssets;
        self.suggestionView.imageDataSoure = _selectImages;
        MLog(@"arrayOfAssets=%@",arrayOfAssets);
    }];
}

- (void)showPickerWhenCompleted:(void (^)(NSArray *assets)) handler {
    _handler = handler;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_assetGroupViewController];
    navController.navigationBar.tintColor = [UIColor colorWithRed:0x4a/0xff green:0x4a/0xff blue:0x4a/0xff alpha:1];
    navController.navigationBar.barTintColor = [UIColor whiteColor];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)DMAssetGroupViewController:(DMAssetGroupViewController *)assetGroupViewController didFinishPickingImagesWithAssets:(NSArray *)assetss {
    if (_handler) {
        _handler(assetss);
    }
}

- (NSDictionary *)fileObjectFromAsset:(ALAsset *) asset {
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    NSString *path = [[NSTemporaryDirectory()stringByStandardizingPath] stringByAppendingPathComponent:rep.filename];
    Byte *buffer = (Byte*)malloc(rep.size);
    NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
    NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
    [data writeToFile:path atomically:YES];
    
    //  UIImage *thumbnail = [[UIImage alloc] initWithCGImage:asset.thumbnail];
    //  NSData *jpegData = UIImageJPEGRepresentation(thumbnail, 0.5f);
    //  NSString *imageBase64 = [jpegData base64EncodedStringWithOptions:0];
    
    return @{@"uri": [[NSURL fileURLWithPath:path] absoluteString], @"path":path};
}

- (void)setAssetGroupViewController:(DMAssetGroupViewController *)assetGroupViewController {
    _assetGroupViewController = assetGroupViewController;
    assetGroupViewController.delegate = self;
}

@end
