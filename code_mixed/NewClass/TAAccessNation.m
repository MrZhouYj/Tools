//
//  TAAccessNation.m
//  JLGP
//
//  Created by  on 2019/11/11.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAAccessNation.h"

@implementation TAAccessNation

+ (NSArray *)getCodeBigArray:(NSArray<TAAccessNation *> *)array{
    NSMutableArray * currencys = @[].mutableCopy;
    for (TAAccessNation *model in array) {
        [currencys addObject:model.code_big];
    }
    return currencys;
}

+(NSArray*)getModels:(NSArray*)array{
    
    NSMutableArray * marketsArray = @[].mutableCopy;
    for (NSDictionary * dic in array) {
        TAAccessNation * model = [TAAccessNation new];
        [model setValuesForKeysWithDictionary:dic];
        [marketsArray addObject:model];
    }
    return marketsArray;
    
}

-(NSString *)code_big{
    return [self.code uppercaseString];
}

@end
