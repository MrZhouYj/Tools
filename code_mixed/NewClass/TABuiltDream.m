//
//  TABuiltDream.m
//  JLGP
//
//  Created by  on 2019/11/7.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TABuiltDream.h"

@implementation TABuiltDream

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
   if([key isEqualToString:@"id"])
     self.ID = value;
}

+(NSArray*)getModels:(NSArray*)array{
    
    if (array.count) {
        NSMutableArray * marketsArray = @[].mutableCopy;
           for (NSDictionary * dic in array) {
               TABuiltDream * model = [TABuiltDream new];
               [model setValuesForKeysWithDictionary:dic];
               [marketsArray addObject:model];
           }
        [TABuiltDream clearTable];
        [TABuiltDream saveObjects:marketsArray];
               
        return marketsArray;
    }else{
        return [TABuiltDream findAll];
    }
}

@end
