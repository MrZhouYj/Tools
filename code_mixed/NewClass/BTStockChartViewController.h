//
//  YStockChartViewController.h
//  BTC-Kline
//
//  Created by yate1996 on 16/4/27.
//  Copyright © 2016年 yate1996. All rights reserved.
//  K线

#import <UIKit/UIKit.h>

@class TAAmericaStudy;
@class TAStrongAsking;

typedef void(^buySellCoinbackBlock)(TAAmericaStudy* model,TradingType type);

@interface BTStockChartViewController : TASlidingHotels

@property (nonatomic, strong) TAStrongAsking *currencyModel;

@property (nonatomic, copy) buySellCoinbackBlock backBlock;

@property (nonatomic, strong) TAAmericaStudy * currentSymbolModel;

@end
