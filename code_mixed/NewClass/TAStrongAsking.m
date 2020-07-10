//
//  TAStrongAsking.m
//  JLGP
//

#import "TAStrongAsking.h"

@implementation TAStrongAsking

-(instancetype)init{
    self = [super init];
    if (self) {
        _count = 0.0;
        _high = 0.0;
        _low = 0.0;
        _close = 0.0;
        _rate = 0.0;
        _count = 0.0;
        _ChangeType = 0.0;
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
   if([key isEqualToString:@"id"])
     self.ID = value;
}

-(void)setCode:(NSString *)code{
    _code = code;
    _code_big = [code uppercaseString];
}


+(instancetype)modelWithDictionary:(NSDictionary *)dic key:(NSString *)key{
    
    TAStrongAsking * model = [TAStrongAsking new];
    [model setValuesForKeysWithDictionary:dic];
    model.key_word = key;
    return model;
}

+(NSArray*)getModels:(NSArray*)array{
    
    NSMutableArray * marketsArray = @[].mutableCopy;
    for (NSDictionary * dic in array) {
        TAStrongAsking * model = [TAStrongAsking new];
        [model setValuesForKeysWithDictionary:dic];
        [marketsArray addObject:model];
    }
      
    return marketsArray;
    
}

+ (void)saveModels:(NSArray *)cuttencies byKey:(NSString *)key{
    
    NSMutableArray * mutArray = @[].mutableCopy;
    for (NSDictionary * dic in cuttencies) {
        TAStrongAsking * model = [TAStrongAsking modelWithDictionary:dic key:key];
        [mutArray addObject:model];
    }
   
    NSString * sql = NSStringFormat(@"WHERE key_word = '%@'",key);
    NSArray * localData = [TAStrongAsking findByCriteria:sql];
    
    if (localData.count) {
        BOOL isDelete = [TAStrongAsking deleteObjectsByCriteria:sql];
        if (isDelete) {
            
            [TAStrongAsking saveObjects:mutArray];
        }else{
            NSLog(@"删除失败");
        }
    }else{
        [TAStrongAsking saveObjects:mutArray];
    }
}

+ (NSArray<TAStrongAsking *> *)getModelsByKey:(NSString *)key{
    
    NSString * sql = NSStringFormat(@"WHERE key_word = '%@'",key);
    NSArray * localData = [TAStrongAsking findByCriteria:sql];
    
    return localData;
}

+ (NSArray<TAStrongAsking*>*)getTransferableModels{
    NSString * sql = @"WHERE key_word = 'all_currencies' and is_transferable = '1'";
    NSArray * localData = [TAStrongAsking findByCriteria:sql];
    NSLog(@"%@",localData);
    return localData;
}
+ (NSArray<TAStrongAsking*>*)getDepositableModels{
    NSString * sql = @"WHERE key_word = 'all_currencies' and is_depositable = '1'";
    NSArray * localData = [TAStrongAsking findByCriteria:sql];
    
    return localData;
}
+ (NSArray<TAStrongAsking*>*)getWithdrawableModels{
    NSString * sql = @"WHERE key_word = 'all_currencies' and is_withdrawable = '1'";
    NSArray * localData = [TAStrongAsking findByCriteria:sql];
    
    return localData;
}


+ (NSArray *)getCodeBigArray:(NSArray *)array{
    
    NSMutableArray * mutArray = @[].mutableCopy;
    for (TAStrongAsking * model in array) {
        [mutArray addObject:model.code_big];
    }
    return mutArray;
}

@end
