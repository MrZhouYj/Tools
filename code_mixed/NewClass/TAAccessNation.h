//
//  TAAccessNation.h
//  JLGP
//
//  Created by  on 2019/11/11.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAThoseSnowing.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAAccessNation : TAThoseSnowing

@property (nonatomic, copy) NSString * locked;
@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * code_big;
@property (nonatomic, copy) NSString * balance;
@property (nonatomic, copy) NSString * currency_cny_amount;
@property (nonatomic, copy) NSString * handling;
@property (nonatomic, copy) NSString * total;
@property (nonatomic, assign) BOOL enable_otc;
@property (nonatomic, assign) BOOL enable_spot;
@property (nonatomic, assign) BOOL enable_stock;

+ (NSArray*)getCodeBigArray:(NSArray<TAAccessNation*>*)array;

@end

NS_ASSUME_NONNULL_END
