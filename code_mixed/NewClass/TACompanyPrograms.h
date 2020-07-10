//
//  TACompanyPrograms.h
//  JLGP
//
//  Created by ZEMac on 2019/9/7.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TASlidingHotels.h"

NS_ASSUME_NONNULL_BEGIN
@class TAAmericaStudy;

@interface TACompanyPrograms : TASlidingHotels

@property (nonatomic, strong) TAAmericaStudy * currentSymbolModel;

-(void)didReciveSymbolModelFromOrtherController:(TAAmericaStudy*)model type:(TradingType)type;

@end

NS_ASSUME_NONNULL_END
