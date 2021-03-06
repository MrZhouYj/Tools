//
//  Y-KlineModel.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/28.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineModel.h"
#import "Y_KLineGroupModel.h"
#import "Y_StockChartGlobalVariable.h"

static NSString *const kRise = @"kRise";
static NSString *const kDrop = @"kDrop";
@implementation Y_KLineModel


- (int)coin{
    if (!_coin) {
        _coin = (int)[[decimalNumberWithDouble(self.Open.doubleValue) componentsSeparatedByString:@"."] lastObject].length;
    }
    return _coin;
}

- (int)price{
    if (!_price) {
        _price = (int)[[decimalNumberWithDouble(self.Open.doubleValue) componentsSeparatedByString:@"."] lastObject].length;
    }
    return _price;
}

NSString *decimalNumberWithDouble(double conversionValue){
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

- (NSNumber *)RSV_9
{
    if (!_RSV_9) {
        if([self.NineClocksMinPrice compare:self.NineClocksMaxPrice] == NSOrderedSame) {
            _RSV_9 = @100;
        } else {
            _RSV_9 = @((self.Close.doubleValue - self.NineClocksMinPrice.doubleValue) * 100 / (self.NineClocksMaxPrice.doubleValue - self.NineClocksMinPrice.doubleValue));
        }
    }
    return _RSV_9;
}
- (NSNumber *)KDJ_K
{
    if (!_KDJ_K) {
        _KDJ_K = @((self.RSV_9.doubleValue + 2 * (self.PreviousKlineModel.KDJ_K ? self.PreviousKlineModel.KDJ_K.doubleValue : 50) )/3);
    }
    return _KDJ_K;
}

- (NSNumber *)KDJ_D
{
    if(!_KDJ_D) {
        _KDJ_D = @((self.KDJ_K.doubleValue + 2 * (self.PreviousKlineModel.KDJ_D ? self.PreviousKlineModel.KDJ_D.doubleValue : 50))/3);
    }
    return _KDJ_D;
}
- (NSNumber *)KDJ_J
{
    if(!_KDJ_J) {
        _KDJ_J = @(3*self.KDJ_K.doubleValue - 2*self.KDJ_D.doubleValue);
    }
    return _KDJ_J;
}

- (NSNumber *)MA7
{
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_MA7) {
            
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            
            if (index >= 6) {
                if (index > 6) {
                    _MA7 = @((self.SumOfLastClose.doubleValue - self.ParentGroupModel.models[index - 7].SumOfLastClose.doubleValue) / 7);
                } else {
                    _MA7 = @(self.SumOfLastClose.doubleValue / 7);
                }
            }
        }
    } else {
        return self.EMA7;
    }
    return _MA7;
}
#pragma mark MA 自定义生成
-(NSNumber *)MA:(int)num{
    
    NSNumber * ma = [NSNumber new];
    
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= num-1) {
            if (index > num-1) {
                ma = @((self.SumOfLastClose.doubleValue - self.ParentGroupModel.models[index - 1].SumOfLastClose.doubleValue) / num);
            } else {
                ma = @(self.SumOfLastClose.doubleValue / num);
            }
        }
    } else {
        return [self EMA:num];
    }
    return ma;
}

-(NSNumber*)EMA:(int)num{
#pragma mark 获取上一个数据的参数  ？？？？？？ 待解决
    NSNumber * ema = @((2 * self.Close.doubleValue + (num-1) * self.PreviousKlineModel.EMA26.doubleValue)/(num+1));
    return ema;
}

- (NSNumber *)Volume_MA7
{
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_Volume_MA7) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 6) {
                if (index > 6) {
                    _Volume_MA7 = @((self.SumOfLastVolume.doubleValue - self.ParentGroupModel.models[index - 7].SumOfLastVolume.doubleValue) / 7);
                } else {
                    _Volume_MA7 = @(self.SumOfLastVolume.doubleValue / 7);
                }
            }
        }
    } else {
        return self.Volume_EMA7;
    }
    return _Volume_MA7;
}
- (NSNumber *)Volume_EMA7
{
    if(!_Volume_EMA7) {
        _Volume_EMA7 = @((self.Volume + 3 * self.PreviousKlineModel.Volume_EMA7.doubleValue)/4);
    }
    return _Volume_EMA7;
}
//// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
- (NSNumber *)EMA7
{
    if(!_EMA7) {
        _EMA7 = @((self.Close.doubleValue + 3 * self.PreviousKlineModel.EMA7.doubleValue)/4);
    }
    return _EMA7;
}

- (NSNumber *)MA5
{
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_MA5) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 4) {
                if (index > 4) {
                    _MA5 = @((self.SumOfLastClose.doubleValue - self.ParentGroupModel.models[index - 4].SumOfLastClose.doubleValue) / 5);
                } else {
                    _MA5 = @(self.SumOfLastClose.doubleValue / 5);
                }
            }
        }
    } else {
        return self.EMA5;
    }
    return _MA5;
}

- (NSNumber *)Volume_MA5
{
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_Volume_MA5) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 4) {
                if (index > 4) {
                    _Volume_MA5 = @((self.SumOfLastVolume.doubleValue - self.ParentGroupModel.models[index - 5].SumOfLastVolume.doubleValue) / 5);
                } else {
                    _Volume_MA5 = @(self.SumOfLastVolume.doubleValue / 5);
                }
            }
        }
    } else {
        return self.Volume_EMA5;
    }
    return _Volume_MA5;
}
- (NSNumber *)Volume_EMA5
{
    if(!_Volume_EMA5) {
        _Volume_EMA5 = @((2 * self.Volume + 4 * self.PreviousKlineModel.Volume_EMA5.doubleValue)/6);
    }
    return _Volume_EMA5;
}
//// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
- (NSNumber *)EMA5
{
    if(!_EMA5) {
        _EMA5 = @((2 * self.Close.doubleValue + 4 * self.PreviousKlineModel.EMA5.doubleValue)/6);
    }
    return _EMA5;
}

- (NSNumber *)MA10
{
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_MA10) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 9) {
                if (index > 9) {
                    _MA10 = @((self.SumOfLastClose.doubleValue - self.ParentGroupModel.models[index - 10].SumOfLastClose.doubleValue) / 10);
                } else {
                    _MA10 = @(self.SumOfLastClose.doubleValue / 10);
                }
            }
        }
    } else {
        return self.EMA10;
    }
    return _MA10;
}

- (NSNumber *)Volume_MA10
{
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_Volume_MA10) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 9) {
                if (index > 9) {
                    _Volume_MA10 = @((self.SumOfLastVolume.doubleValue - self.ParentGroupModel.models[index - 10].SumOfLastVolume.doubleValue) / 10);
                } else {
                    _Volume_MA10 = @(self.SumOfLastVolume.doubleValue / 10);
                }
            }
        }
    } else {
        return self.Volume_EMA10;
    }
    return _Volume_MA10;
}
- (NSNumber *)Volume_EMA10
{
    if(!_Volume_EMA10) {
        _Volume_EMA10 = @((2 * self.Volume + 9 * self.PreviousKlineModel.Volume_EMA10.doubleValue)/11);
    }
    return _Volume_EMA10;
}
//// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
- (NSNumber *)EMA10
{
    if(!_EMA10) {
        _EMA10 = @((2 * self.Close.doubleValue + 9 * self.PreviousKlineModel.EMA10.doubleValue)/11);
    }
    return _EMA10;
}

- (NSNumber *)EMA30
{
    if(!_EMA30) {
        _EMA30 = @((2 * self.Close.doubleValue + 29 * self.PreviousKlineModel.EMA30.doubleValue)/31);
    }
    return _EMA30;
}

- (NSNumber *)EMA12
{
    if(!_EMA12) {
        _EMA12 = @((2 * self.Close.doubleValue + 11 * self.PreviousKlineModel.EMA12.doubleValue)/13);
    }
    return _EMA12;
}

- (NSNumber *)EMA26
{
    if (!_EMA26) {
        _EMA26 = @((2 * self.Close.doubleValue + 25 * self.PreviousKlineModel.EMA26.doubleValue)/27);
    }
    return _EMA26;
}

- (NSNumber *)MA30
{
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_MA30) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 29) {
                if (index > 29) {
                    _MA30 = @((self.SumOfLastClose.doubleValue - self.ParentGroupModel.models[index - 30].SumOfLastClose.doubleValue) / 30);
                } else {
                    _MA30 = @(self.SumOfLastClose.doubleValue / 30);
                }
            }
        }
    } else {
        return self.EMA30;
    }
    return _MA30;
}

- (NSNumber *)Volume_MA30
{
    if([Y_StockChartGlobalVariable isEMALine] == Y_StockChartTargetLineStatusMA)
    {
        if (!_Volume_MA30) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 29) {
                if (index > 29) {
                    _Volume_MA30 = @((self.SumOfLastVolume.doubleValue - self.ParentGroupModel.models[index - 30].SumOfLastVolume.doubleValue) / 30);
                } else {
                    _Volume_MA30 = @(self.SumOfLastVolume.doubleValue / 30);
                }
            }
        }
    } else {
        return self.Volume_EMA30;
    }
    return _Volume_MA30;
}

- (NSNumber *)Volume_EMA30
{
    if(!_Volume_EMA30) {
        _Volume_EMA30 = @((2 * self.Volume + 29 * self.PreviousKlineModel.Volume_EMA30.doubleValue)/31);
    }
    return _Volume_EMA30;
}

- (NSNumber *)MA12
{
    if (!_MA12) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 11) {
            if (index > 11) {
                _MA12 = @((self.SumOfLastClose.doubleValue - self.ParentGroupModel.models[index - 12].SumOfLastClose.doubleValue) / 12);
            } else {
                _MA12 = @(self.SumOfLastClose.doubleValue / 12);
            }
        }
    }
    return _MA12;
}

- (NSNumber *)MA26
{
    if (!_MA26) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 25) {
            if (index > 25) {
                _MA26 = @((self.SumOfLastClose.doubleValue - self.ParentGroupModel.models[index - 26].SumOfLastClose.doubleValue) / 26);
            } else {
                _MA26 = @(self.SumOfLastClose.doubleValue / 26);
            }
        }
    }
    return _MA26;
}

- (NSNumber *)SumOfLastClose
{
    if(!_SumOfLastClose) {
        _SumOfLastClose = @(self.PreviousKlineModel.SumOfLastClose.doubleValue + self.Close.doubleValue);
        NSLog(@"self.close %@  sumOfLastClose %@",self.Close,_SumOfLastClose);
    }
    return _SumOfLastClose;
}

- (NSNumber *)SumOfLastVolume
{
    if(!_SumOfLastVolume) {
        _SumOfLastVolume = @(self.PreviousKlineModel.SumOfLastVolume.doubleValue + self.Volume);
    }
    return _SumOfLastVolume;
}

- (NSNumber *)NineClocksMinPrice
{
    if (!_NineClocksMinPrice) {
//        if([self.ParentGroupModel.models indexOfObject:self] >= 8)
//        {
            [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedDescending];
//        } else {
//            _NineClocksMinPrice = @0;
//        }
    }
    return _NineClocksMinPrice;
}

- (NSNumber *)NineClocksMaxPrice {
    if (!_NineClocksMaxPrice) {
        if([self.ParentGroupModel.models indexOfObject:self] >= 8)
        {
            [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedAscending];
        } else {
            _NineClocksMaxPrice = @0;
        }
    }
    return _NineClocksMaxPrice;
}

- (NSNumber *)FourteenClocksMinPrice
{
    if (!_FourteenClocksMinPrice) {
        [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedDescending];
    }
    return _FourteenClocksMinPrice;
}

- (NSNumber *)FourteenClocksMaxPrice
{
    if (!_FourteenClocksMaxPrice) {
        if([self.ParentGroupModel.models indexOfObject:self] >= 14)
        {
            [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedAscending];
        } else {
            _FourteenClocksMaxPrice = @0;
        }
    }
    return _FourteenClocksMaxPrice;
}


////DIF=EMA（12）-EMA（26）         DIF的值即为红绿柱；
//
////今日的DEA值=前一日DEA*8/10+今日DIF*2/10.

- (NSNumber *)DIF
{
    if(!_DIF) {
        _DIF = @(self.EMA12.doubleValue - self.EMA26.doubleValue);
    }
    return _DIF;
}

//已验证
-(NSNumber *)DEA
{
    if(!_DEA) {
        _DEA = @(self.PreviousKlineModel.DEA.doubleValue * 0.8 + 0.2*self.DIF.doubleValue);
    }
    return _DEA;
}

//已验证
- (NSNumber *)MACD
{
    if(!_MACD) {
        _MACD = @(2*(self.DIF.doubleValue - self.DEA.doubleValue));
    }
    return _MACD;
}

#pragma mark BOLL线

- (NSNumber *)MA20{
    
    if (!_MA20) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 19) {
            if (index > 19) {
                _MA20 = @((self.SumOfLastClose.doubleValue - self.ParentGroupModel.models[index - 20].SumOfLastClose.doubleValue) / 20);
            } else {
                _MA20 = @(self.SumOfLastClose.doubleValue / 20);
            }
        }
    }
    return _MA20;
    
}

- (NSNumber *)BOLL_MB {
    
    if(!_BOLL_MB) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 19) {
            
            if (index > 19) {
                _BOLL_MB = @((self.SumOfLastClose.doubleValue - self.ParentGroupModel.models[index - 19].SumOfLastClose.doubleValue) / 19);
                
            } else {
                
                _BOLL_MB = @(self.SumOfLastClose.doubleValue / index);
                
            }
        }
        
        // NSLog(@"lazyMB:\n _BOLL_MB: %@", _BOLL_MB);
        
    }
    
    return _BOLL_MB;
}

- (NSNumber *)BOLL_MD {
    
    if (!_BOLL_MD) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        
        if (index >= 20) {
            
            _BOLL_MD = @(sqrt((self.PreviousKlineModel.BOLL_SUBMD_SUM.doubleValue - self.ParentGroupModel.models[index - 20].BOLL_SUBMD_SUM.doubleValue)/ 20));
            
        }
        
    }
    
    // NSLog(@"lazy:\n_BOLL_MD:%@ -- BOLL_SUBMD:%@",_BOLL_MD,_BOLL_SUBMD);
    
    return _BOLL_MD;
}

- (NSNumber *)BOLL_UP {
    if (!_BOLL_UP) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 20) {
            _BOLL_UP = @(self.BOLL_MB.doubleValue + 2 * self.BOLL_MD.doubleValue);
        }
    }
    
    // NSLog(@"lazy:\n_BOLL_UP:%@ -- BOLL_MD:%@",_BOLL_UP,_BOLL_MD);
    
    return _BOLL_UP;
}

- (NSNumber *)BOLL_DN {
    if (!_BOLL_DN) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 20) {
            _BOLL_DN = @(self.BOLL_MB.doubleValue - 2 * self.BOLL_MD.doubleValue);
        }
    }
    
    // NSLog(@"lazy:\n_BOLL_DN:%@ -- BOLL_MD:%@",_BOLL_DN,_BOLL_MD);
    
    return _BOLL_DN;
}

- (NSNumber *)BOLL_SUBMD_SUM {
    
    if (!_BOLL_SUBMD_SUM) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 20) {
            
            _BOLL_SUBMD_SUM = @(self.PreviousKlineModel.BOLL_SUBMD_SUM.doubleValue + self.BOLL_SUBMD.doubleValue);
            
        }
    }
    
    // NSLog(@"lazy:\n_BOLL_SUBMD_SUM:%@ -- BOLL_SUBMD:%@",_BOLL_SUBMD_SUM,_BOLL_SUBMD);
    
    return _BOLL_SUBMD_SUM;
}

- (NSNumber *)BOLL_SUBMD{
    
    if (!_BOLL_SUBMD) {
        
        if ([self.ParentGroupModel.models containsObject:self]) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            
            if (index >= 20) {
                
                _BOLL_SUBMD = @((self.Close.doubleValue - self.MA20.doubleValue) * ( self.Close.doubleValue - self.MA20.doubleValue));
                            
            }
        }
    }
    
    return _BOLL_SUBMD;
}

//计算RSI指标
- (NSNumber *)RSI_6
{
    if (!_RSI_6) {
        if ([self.ParentGroupModel.models containsObject:self]) {
            NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
            if (index >= 6) {
                _RSI_6 = @([self getRSIWithPreviousPriceOfChangeArr:[self RSI_PreviousPriceWithDayCount:6] dayCount:6]);
            }
        }
    }
    
    return _RSI_6;
}

- (NSNumber *)RSI_12
{
    if (!_RSI_12) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 12) {
            _RSI_12 = @([self getRSIWithPreviousPriceOfChangeArr:[self RSI_PreviousPriceWithDayCount:12] dayCount:12]);
        }
    }
    
    return _RSI_12;
}

- (NSNumber *)RSI_24
{
    if (!_RSI_24) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 24) {
            _RSI_24 = @([self getRSIWithPreviousPriceOfChangeArr:[self RSI_PreviousPriceWithDayCount:24] dayCount:24]);
        }
    }
    
    return _RSI_24;
}

- (NSMutableArray *)RSI_PreviousPriceWithDayCount:(NSInteger)dayCount
{
    NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
    
    NSMutableArray *previousPriceArr = [NSMutableArray array];
    for (NSInteger i = index-(dayCount-1); i <= index; i++) {
        if (i > 0) {
            Y_KLineModel *model = self.ParentGroupModel.models[i];
            double close = [model.Close doubleValue];
            double open = [model.PreviousKlineModel.Open doubleValue];
            [previousPriceArr addObject:@(close-open)];
        }
    }
    return previousPriceArr;
}

- (double)getRSIWithPreviousPriceOfChangeArr:(NSArray *)previousPriceOfChangeArr dayCount:(double)dayCount
{
    
    NSDictionary *sumDic = [self getSumOfRiseAndDropWithPreviousPriceOfChangeArr:previousPriceOfChangeArr];
    double riseSum  = [sumDic[kRise] doubleValue];
    double dropSum  = [sumDic[kDrop] doubleValue];
    double riseRate = riseSum/dayCount;
    double dropRate = dropSum/dayCount*(-1);
    double RS       = riseRate/dropRate;
    double RSI      = (100-(100/(1+RS)));
    return RSI;
}

- (NSDictionary *)getSumOfRiseAndDropWithPreviousPriceOfChangeArr:(NSArray *)previousPriceOfChangeArr
{
    __block double sumOfRise = 0;
    __block double sumOfDrop = 0;
    
    [previousPriceOfChangeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        double changeValue = [obj doubleValue];
        if (changeValue >= 0) {
            
            sumOfRise +=changeValue;
        }else
        {
            sumOfDrop += changeValue;
        }
        
    }];
    NSDictionary *resultDic = [NSDictionary dictionaryWithObjectsAndKeys:@(sumOfRise),kRise,@(sumOfDrop),kDrop,nil];
    return resultDic;
}

/*
 WR1一般是10天买卖强弱指标；
 WR2一般是6天买卖强弱指标。
 以N日威廉指标为例，
 WR(N) = 100 * [ HIGH(N)-C ] / [ HIGH(N)-LOW(N) ]
 C：当日收盘价
 HIGH(N)：N日内的最高价
 LOW(n)：N日内的最低价 [1]
 */
- (NSNumber *)WR
{
    if (!_WR) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 14) {
            _WR = @(100 * (self.FourteenClocksMaxPrice.doubleValue - self.Close.doubleValue) / (self.FourteenClocksMaxPrice.doubleValue-self.FourteenClocksMinPrice.doubleValue));
        }else{
            _WR = @0;
        }
    }
    
    return _WR;
}

- (Y_KLineModel *)PreviousKlineModel
{
    if (!_PreviousKlineModel) {
        _PreviousKlineModel = [Y_KLineModel new];
        _PreviousKlineModel.DIF = @(0);
        _PreviousKlineModel.DEA = @(0);
        _PreviousKlineModel.MACD = @(0);
        _PreviousKlineModel.MA7 = @(0);
//        _PreviousKlineModel.MA5 = @(0);
//        _PreviousKlineModel.MA10 = @(0);
        _PreviousKlineModel.MA12 = @(0);
        _PreviousKlineModel.MA26 = @(0);
        _PreviousKlineModel.MA30 = @(0);
        _PreviousKlineModel.EMA7 = @(0);
        _PreviousKlineModel.EMA12 = @(0);
//        _PreviousKlineModel.EMA5 = @(0);
//        _PreviousKlineModel.EMA10 = @(0);
        _PreviousKlineModel.EMA26 = @(0);
        _PreviousKlineModel.EMA30 = @(0);
        _PreviousKlineModel.Volume_MA7 = @(0);
        _PreviousKlineModel.Volume_MA30 = @(0);
//        _PreviousKlineModel.Volume_MA5 = @(0);
//        _PreviousKlineModel.Volume_MA10 = @(0);
        _PreviousKlineModel.Volume_EMA7 = @(0);
        _PreviousKlineModel.Volume_EMA30 = @(0);
//        _PreviousKlineModel.Volume_EMA5 = @(0);
//        _PreviousKlineModel.Volume_EMA10 = @(0);
        _PreviousKlineModel.SumOfLastClose = @(0);
        _PreviousKlineModel.SumOfLastVolume = @(0);
        _PreviousKlineModel.KDJ_K = @(50);
        _PreviousKlineModel.KDJ_D = @(50);

        _PreviousKlineModel.MA20 = @(0);
        _PreviousKlineModel.BOLL_MD = @(0);
        _PreviousKlineModel.BOLL_MB = @(0);
        _PreviousKlineModel.BOLL_DN = @(0);
        _PreviousKlineModel.BOLL_UP = @(0);
        _PreviousKlineModel.BOLL_SUBMD_SUM = @(0);
        _PreviousKlineModel.BOLL_SUBMD = @(0);
        
    }
    return _PreviousKlineModel;
}
- (Y_KLineGroupModel *)ParentGroupModel
{
    if(!_ParentGroupModel) {
        _ParentGroupModel = [Y_KLineGroupModel new];
    }
    return _ParentGroupModel;
}
//对Model数组进行排序，初始化每个Model的最新9Clock的最低价和最高价
- (void)rangeLastNinePriceByArray:(NSArray<Y_KLineModel *> *)models condition:(NSComparisonResult)cond
{
    if (models.count < 8) {
//        NSLog(@"model数据太少");
    }
    else{
        switch (cond) {
                //最高价
            case NSOrderedAscending:
            {
                //            第一个循环结束后，ClockFirstValue为最小值
                for (NSInteger j = 7; j >= 1; j--)
                {
                    NSNumber *emMaxValue = @0;
                    
                    NSInteger em = j;
                    
                    while ( em >= 0 )
                    {
                        if([emMaxValue compare:models[em].High] == cond)
                        {
                            emMaxValue = models[em].High;
                        }
                        em--;
                    }
                    //NSLog(@"%f",emMaxValue.doubleValue);
                    models[j].NineClocksMaxPrice = emMaxValue;
                }
                //第一个循环结束后，ClockFirstValue为最小值
                for (NSInteger i = 0, j = 8; j < models.count; i++,j++)
                {
                    NSNumber *emMaxValue = @0;
                    
                    NSInteger em = j;
                    
                    while ( em >= i )
                    {
                        if([emMaxValue compare:models[em].High] == cond)
                        {
                            emMaxValue = models[em].High;
                        }
                        em--;
                    }
                    //NSLog(@"%f",emMaxValue.doubleValue);
                    
                    models[j].NineClocksMaxPrice = emMaxValue;
                }
            }
                break;
            case NSOrderedDescending:
            {
                //第一个循环结束后，ClockFirstValue为最小值
                
                for (NSInteger j = 7; j >= 1; j--)
                {
                    NSNumber *emMinValue = @(10000000000);
                    
                    NSInteger em = j;
                    
                    while ( em >= 0 )
                    {
                        if([emMinValue compare:models[em].Low] == cond)
                        {
                            emMinValue = models[em].Low;
                        }
                        em--;
                    }
                    models[j].NineClocksMinPrice = emMinValue;
                }
                
                for (NSInteger i = 0, j = 8; j < models.count; i++,j++)
                {
                    NSNumber *emMinValue = @(10000000000);
                    
                    NSInteger em = j;
                    
                    while ( em >= i )
                    {
                        if([emMinValue compare:models[em].Low] == cond)
                        {
                            emMinValue = models[em].Low;
                        }
                        em--;
                    }
                    models[j].NineClocksMinPrice = emMinValue;
                }
            }
                break;
            default:
                break;
        }
    }
    
}

//对Model数组进行排序，初始化每个Model的最新14Clock的最低价和最高价
- (void)rangeLastFourteenPriceByArray:(NSArray<Y_KLineModel *> *)models condition:(NSComparisonResult)cond
{
    if (models.count < 14) {
//        NSLog(@"model数据太少");
    }
    else{
        switch (cond) {
                //最高价
            case NSOrderedAscending:
            {
                //            第一个循环结束后，ClockFirstValue为最小值
                for (NSInteger j = 12; j >= 1; j--)
                {
                    NSNumber *emMaxValue = @0;
                    
                    NSInteger em = j;
                    
                    while ( em >= 0 )
                    {
                        if([emMaxValue compare:models[em].High] == cond)
                        {
                            emMaxValue = models[em].High;
                        }
                        em--;
                    }
                    //NSLog(@"%f",emMaxValue.doubleValue);
                    models[j].FourteenClocksMaxPrice = emMaxValue;
                }
                //第一个循环结束后，ClockFirstValue为最小值
                for (NSInteger i = 0, j = 13; j < models.count; i++,j++)
                {
                    NSNumber *emMaxValue = @0;
                    
                    NSInteger em = j;
                    
                    while ( em >= i )
                    {
                        if([emMaxValue compare:models[em].High] == cond)
                        {
                            emMaxValue = models[em].High;
                        }
                        em--;
                    }
                    //NSLog(@"%f",emMaxValue.doubleValue);
                    
                    models[j].FourteenClocksMaxPrice = emMaxValue;
                }
            }
                break;
            case NSOrderedDescending:
            {
                //第一个循环结束后，ClockFirstValue为最小值
                
                for (NSInteger j = 12; j >= 1; j--)
                {
                    NSNumber *emMinValue = @(10000000000);
                    
                    NSInteger em = j;
                    
                    while ( em >= 0 )
                    {
                        if([emMinValue compare:models[em].Low] == cond)
                        {
                            emMinValue = models[em].Low;
                        }
                        em--;
                    }
                    models[j].FourteenClocksMinPrice = emMinValue;
                }
                
                for (NSInteger i = 0, j = 13; j < models.count; i++,j++)
                {
                    NSNumber *emMinValue = @(10000000000);
                    
                    NSInteger em = j;
                    
                    while ( em >= i )
                    {
                        if([emMinValue compare:models[em].Low] == cond)
                        {
                            emMinValue = models[em].Low;
                        }
                        em--;
                    }
                    models[j].FourteenClocksMinPrice = emMinValue;
                }
            }
                break;
            default:
                break;
        }
    }
    
}


- (void) initWithArray:(NSArray *)arr;
{
    NSAssert(arr.count == 6, @"数组长度不足");

    if (self)
    {
        _Date = arr[0];
        _Open = @([arr[1] doubleValue]);
        _High = @([arr[2] doubleValue]);
        _Low = @([arr[3] doubleValue]);  
        _Close = @([arr[4] doubleValue]);
        _Volume = [arr[5] doubleValue];
        
        self.SumOfLastClose = @(_Close.doubleValue + self.PreviousKlineModel.SumOfLastClose.doubleValue);
        
        self.SumOfLastVolume = @(_Volume + self.PreviousKlineModel.SumOfLastVolume.doubleValue);
        
    }
}

- (void) initWithDict:(NSDictionary *)dict
{
    
    if (self)
    {
        _Date = dict[@"id"];
        _Open = @([dict[@"open"] doubleValue]);
        _High = @([dict[@"high"] doubleValue]);
        _Low = @([dict[@"low"] doubleValue]);
        _Close = @([dict[@"close"] doubleValue]);
        _Volume = [dict[@"amount"] doubleValue];
        
//        _Volume = [dict[@"amount"] doubleValue];
        self.SumOfLastClose = @(_Close.doubleValue + self.PreviousKlineModel.SumOfLastClose.doubleValue);
        self.SumOfLastVolume = @(_Volume + self.PreviousKlineModel.SumOfLastVolume.doubleValue);

    }
}

- (void)initFirstModel
{
//    _SumOfLastClose = _Close;
//    _SumOfLastVolume = @(_Volume);
    _KDJ_K = @(55.27);
    _KDJ_D = @(55.27);
    _KDJ_J = @(55.27);
    _MA7 = _Close;
//    _MA12 = _Close;
//    _MA26 = _Close;
    _MA30 = _Close;
    _EMA7 = _Close;
    _EMA12 = _Close;
    _EMA26 = _Close;
    _EMA30 = _Close;
//    _EMA5 = _Close;
//    _EMA10 = _Close;
    _NineClocksMinPrice = _Low;
    _NineClocksMaxPrice = _High;
    _FourteenClocksMinPrice = _Low;
    _FourteenClocksMaxPrice = _High;
    [self DIF];
    [self DEA];
    [self MACD];
    [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedAscending];
    [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedDescending];
    [self rangeLastFourteenPriceByArray:self.ParentGroupModel.models condition:NSOrderedAscending];
    [self rangeLastFourteenPriceByArray:self.ParentGroupModel.models condition:NSOrderedDescending];
    [self RSV_9];
    [self KDJ_K];
    [self KDJ_D];
    [self KDJ_J];
    [self RSI_6];
    [self RSI_12];
    [self RSI_24];
    [self WR];
    [self MA20];
    [self BOLL_MD];
    [self BOLL_MB];
    [self BOLL_UP];
    [self BOLL_DN];
    [self BOLL_SUBMD];
    [self BOLL_SUBMD_SUM];
    
}

- (void)initData {
   
    [self MA7];
//    [self MA5];
//    [self MA10];
    [self MA12];
    [self MA26];
    [self MA30];
    [self EMA7];
//    [self EMA5];
//    [self EMA10];
    [self EMA12];
    [self EMA26];
    [self EMA30];
    
    [self DIF];
    [self DEA];
    [self MACD];
    [self NineClocksMaxPrice];
    [self NineClocksMinPrice];
    [self RSV_9];
    [self KDJ_K];
    [self KDJ_D];
    [self KDJ_J];
    [self RSI_6];
    [self RSI_12];
    [self RSI_24];
    [self FourteenClocksMaxPrice];
    [self FourteenClocksMinPrice];
    [self WR];
    [self MA20];
    [self BOLL_MD];
    [self BOLL_MB];
    [self BOLL_UP];
    [self BOLL_DN];
    [self BOLL_SUBMD];
    [self BOLL_SUBMD_SUM];

}
@end
