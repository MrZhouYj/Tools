//
//  CACurrencyMoneyModel.m
//  JLGP
//
//  Created by  on 2019/11/11.
//  Copyright © 2019 CA. All rights reserved.
//

#import "CACurrencyMoneyModel.h"

@implementation CACurrencyMoneyModel

+ (NSArray *)getCodeBigArray:(NSArray<CACurrencyMoneyModel *> *)array{
    NSMutableArray * currencys = @[].mutableCopy;
    for (CACurrencyMoneyModel *model in array) {
        [currencys addObject:model.code_big];
    }
    return currencys;
}

+(NSArray*)getModels:(NSArray*)array{
    
    NSMutableArray * marketsArray = @[].mutableCopy;
    for (NSDictionary * dic in array) {
        CACurrencyMoneyModel * model = [CACurrencyMoneyModel new];
        [model setValuesForKeysWithDictionary:dic];
        [marketsArray addObject:model];
    }
    return marketsArray;
    
}

-(NSString *)code_big{
    return [self.code uppercaseString];
}

@end
