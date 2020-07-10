//
//  TATransformationStudy.h
//  JLGP
//
//   9/27.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TASlidingHotels.h"

NS_ASSUME_NONNULL_BEGIN

@interface TATransformationStudy : TASlidingHotels

// 0 支付宝 1 微信 2 银行卡
@property (nonatomic, copy) NSString * payType;
@property (nonatomic, strong) NSDictionary * dataDic;

@end

NS_ASSUME_NONNULL_END
