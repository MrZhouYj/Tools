//
//  TATriedWiden.m
//  CADAE-IOS
//
//  Created by  on 2019/11/12.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TATriedWiden.h"

@implementation TATriedWiden

+(NSArray*)getModels:(NSArray*)array{
    
    if (array.count) {
        NSMutableArray * marketsArray = @[].mutableCopy;
           for (NSDictionary * dic in array) {
               TATriedWiden * model = [TATriedWiden new];
               [model setValuesForKeysWithDictionary:dic];
               [marketsArray addObject:model];
           }
        [TATriedWiden clearTable];
        [TATriedWiden saveObjects:marketsArray];
               
        return marketsArray;
    }else{
        return [TATriedWiden findAll];
    }
}


@end
