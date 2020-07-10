//
//  TAProbablyAccess.m
//  JLGP
//
//  Created by  on 2019/11/11.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAProbablyAccess.h"

@implementation TAProbablyAccess

-(void)setNilValueForKey:(NSString *)key{
    if ([key isEqualToString:@"mobile"]) {
        self.mobile = @"";
    }else if ([key isEqualToString:@"email"]){
        self.email = @"";
    }
}

+(NSArray*)getModels:(NSArray*)array{
    
    NSMutableArray * marketsArray = @[].mutableCopy;
    for (NSDictionary * dic in array) {
       TAProbablyAccess * model = [TAProbablyAccess new];
       [model setValuesForKeysWithDictionary:dic];
       [marketsArray addObject:model];
    }
    return marketsArray;
    
}

@end
