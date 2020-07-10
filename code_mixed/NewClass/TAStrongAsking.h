//
//  TAStrongAsking.h
//  JLGP
//
//  Created by  on 2019/11/7.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAThoseSnowing.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAStrongAsking : TAThoseSnowing

@property (nonatomic, assign) CGFloat count;
@property (nonatomic, assign) CGFloat high;
@property (nonatomic, assign) CGFloat low;
@property (nonatomic, assign) CGFloat close;
@property (nonatomic, assign) CGFloat rate;
@property (nonatomic, copy) NSString* change;
@property (nonatomic, assign) NSInteger ChangeType; //涨跌类型 1涨  0跌

@property (nonatomic, assign) BOOL is_transferable; //是否支持转账
@property (nonatomic, assign) BOOL is_depositable; //是否支持充币
@property (nonatomic, assign) BOOL is_withdrawable; //是否支持体现


@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * icon;
@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * code_big;
@property (nonatomic, copy) NSString * key_word;

@property (nonatomic, copy) NSString * min_amount;

@property (nonatomic, strong) NSNumber* balance;
@property (nonatomic, strong) NSNumber* fee;

@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * qrcode;
@property (nonatomic, copy) NSString * position;

+ (instancetype)modelWithDictionary:(NSDictionary*)dic key:(NSString*)key;

+ (void)saveModels:(NSArray*)cuttencies byKey:(NSString*)key;

+ (NSArray<TAStrongAsking*>*)getModelsByKey:(NSString*)key;

+ (NSArray<TAStrongAsking*>*)getTransferableModels;
+ (NSArray<TAStrongAsking*>*)getDepositableModels;
+ (NSArray<TAStrongAsking*>*)getWithdrawableModels;

+ (NSArray*)getCodeBigArray:(NSArray*)array;

@end

NS_ASSUME_NONNULL_END
