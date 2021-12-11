//
//  ABUSigmobFullscreenVideoAdapter.h
//  ABUAdSDK
//
//  Created by bytedance on 2021/9/15.
//

#import <Foundation/Foundation.h>
# if __has_include(<ABUAdSDK/ABUAdSDK.h>)
#import <ABUAdSDK/ABUAdSDK.h>
#else
#import <Ads-Mediation-CN/ABUAdSDK.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface ABUSigmobFullscreenVideoAdapter : NSObject <ABUCustomFullscreenVideoAdapter>

@end

NS_ASSUME_NONNULL_END