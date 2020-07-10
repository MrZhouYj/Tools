//
//  TASymbolRemains.m
//  JLGP
//
//  Created by  on 2019/12/27.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TASymbolRemains.h"

@implementation TASymbolRemains

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
   if([key isEqualToString:@"id"])
   {
       self.ID = value;
   }
}
+(NSArray*)getModels:(NSArray*)array{
    
    NSMutableArray * marketsArray = @[].mutableCopy;
    for (NSDictionary * dic in array) {
        TASymbolRemains * model = [TASymbolRemains new];
        [model dealData:dic];
        [marketsArray addObject:model];
    }
      
    return marketsArray;
    
}

-(void)dealData:(NSDictionary*)dic{
    
      NSArray * allKeys = dic.allKeys;
      NSArray * allProp = self.columeNames;
      
      for (NSString * key in allKeys) {
          if ([allProp containsObject:key]) {
              if (dic[key]) {
                  [self setValue:dic[key] forKey:key];
              }
          }else{
              if ([key isEqualToString:@"id"]) {
                  self.ID = dic[key];
              }
          }
      }
      
}

@end
