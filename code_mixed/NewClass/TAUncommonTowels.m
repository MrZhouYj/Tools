//
//  TAUncommonTowels.m
//  JLGP
//
//  Created by  on 2019/11/7.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAUncommonTowels.h"

@implementation TAUncommonTowels

+(NSArray*)getModels:(NSArray*)array{
    
    if (array.count) {
        NSMutableArray * marketsArray = @[].mutableCopy;
           for (NSDictionary * dic in array) {
               TAUncommonTowels * model = [TAUncommonTowels new];
               [model setValuesForKeysWithDictionary:dic];
               [marketsArray addObject:model];
           }
        
        [TAUncommonTowels clearTable];
        [TAUncommonTowels saveObjects:marketsArray];
        NSLog(@"marketsArray%@",marketsArray);
        return marketsArray;
    }else{
        return [TAUncommonTowels findAll];
    }
}


@end
