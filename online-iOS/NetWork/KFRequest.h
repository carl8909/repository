//
//  KFRequest.h
//  online-iOS
//
//  Created by wuy on 2021/2/4.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#define KF_REQUEST_SUCCESS @"C0000" /**< 请求成功状态码 */

#define KF_VALIDATE_REQUEST(json) \
([json isKindOfClass:[NSDictionary class]] && [[json objectForKey:@"status"] isKindOfClass:[NSString class]] && [[json objectForKey:@"status"] isEqualToString:KF_REQUEST_SUCCESS])

typedef void(^KFRequestCompletionBlock)(id _Nullable responseJSONObject, BOOL success);

#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface KFRequest : YTKRequest

@property (nonatomic, strong) NSMutableDictionary *arguments; /**< 请求参数字典 */

/**
 接口请求
 */
- (void)requestWithCompletionBlockWithCompletion:(KFRequestCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
