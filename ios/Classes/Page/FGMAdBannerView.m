//
//  FGMAdBannerView.m
//  flutter_gromore_ads
//
//  Created by Zero on 2023/1/12.
//

#import "FGMAdBannerView.h"

@interface FGMAdBannerView()<FlutterPlatformView,ABUBannerAdDelegate>
@property (strong,nonatomic) ABUBannerAd *bad;
@property (strong,nonatomic) UIView *bannerView;

@end

@implementation FGMAdBannerView

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger
                       plugin:(FlutterGromoreAdsPlugin*) plugin{
    if (self = [super init]) {
        self.bannerView = [[UIView alloc] init];
        FlutterMethodCall *call=[FlutterMethodCall methodCallWithMethodName:@"AdBannerView" arguments:args];
        [self showAd:call eventSink:plugin.eventSink];
    }
    return self;
}

- (UIView*)view {
    return self.bannerView;
}
// 加载广告
- (void)loadAd:(FlutterMethodCall *)call{
    // 刷新间隔
    int width = [call.arguments[@"width"] intValue];
    int height = [call.arguments[@"height"] intValue];
    self.bad=[[ABUBannerAd alloc] initWithAdUnitID:self.posId rootViewController:self.rootController adSize:CGSizeMake(width, height)];
    self.bad.delegate=self;
    [self.bad loadAdData];
}


#pragma mark ----- ABUBannerAdDelegate -----
/// 加载成功回调
- (void)bannerAdDidLoad:(ABUBannerAd *)bannerAd bannerView:(UIView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
    [self.bannerView addSubview:bannerView];
    // 发送事件
    [self sendEventAction:onAdLoaded];
}

/// 加载失败回调
- (void)bannerAd:(ABUBannerAd *)bannerAd didLoadFailWithError:(NSError *)error {
    NSLog(@"%s-error:%@", __FUNCTION__, error);
    // 发送事件
    [self sendErrorEvent:error];
    // 销毁广告
    [self destoryAd:nil];
}

/// 展示成功回调
- (void)bannerAdDidBecomeVisible:(ABUBannerAd *)bannerAd bannerView:(UIView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdExposure];
}

/// 广告点击回调
- (void)bannerAdDidClick:(ABUBannerAd *)ABUBannerAd bannerView:(UIView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdClicked];
}

/// 广告关闭回调
- (void)bannerAdDidClosed:(ABUBannerAd *)ABUBannerAd bannerView:(UIView *)bannerView dislikeWithReason:(NSArray<NSDictionary *> *)filterwords {
    NSLog(@"%s",__FUNCTION__);
    // 可于此处移除广告view
    [self destoryAd:bannerView];
    // 发送事件
    [self sendEventAction:onAdClosed];
}

// 销毁广告
- (void)destoryAd:(UIView *)bannerView{
        if(bannerView){
            [bannerView removeFromSuperview];
        }
        self.bad.delegate=nil;
        self.bad=nil;
}

@end
