//
//  TASorrowPress.m
//  JLGP
//
//  Created by  on 2019/11/7.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TASorrowPress.h"

@implementation TASorrowPress

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
   if([key isEqualToString:@"id"])
     self.ID = NSStringFormat(@"%@",value);
}

-(NSString *)first_name{
    
    return [CommonMethod getFirstFromString:self.otc_nick_name];
}

-(NSString *)code_big{
    
    return [self.code uppercaseString];
}

-(void)setNilValueForKey:(NSString *)key{
    if ([key isEqualToString:@"is_canceled"]){
        self.is_canceled = false;
    }
}

+(NSArray*)getModels:(NSArray*)array{
    
    NSMutableArray * marketsArray = @[].mutableCopy;
       for (NSDictionary * dic in array) {
           TASorrowPress * model = [TASorrowPress new];
           [model setValuesForKeysWithDictionary:dic];
           [marketsArray addObject:model];
       }
           
    return marketsArray;
}

-(NSString *)stringByLinkWithComma:(NSArray *)pays{
    
    NSLog(@"=--==-===-======%@",pays);
    if (!pays.count) {
        return @"";
    }
    
    NSString * payString = @"";
    for (NSString *pay in pays) {
        payString = [payString stringByAppendingFormat:@"%@,",pay];
    }
    payString = [payString substringToIndex:payString.length-1];
    NSLog(@"======%@",payString);
    return payString;
}

@end
