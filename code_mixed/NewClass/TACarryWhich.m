//
//  TACarryWhich.m
//  JLGP
//
//  Created by  on 2020/6/23.
//  Copyright © 2020 CA. All rights reserved.
//

#import "TACarryWhich.h"

@interface TACarryWhich()

@property (nonatomic, strong) NSArray * accounts;

@end

@implementation TACarryWhich

+ (instancetype)shareAccouts{
    static dispatch_once_t onceToken;
    static TACarryWhich * accounts = nil;
    dispatch_once(&onceToken, ^{
        accounts = [TACarryWhich  new];
    });
    return accounts;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.accounts = @[@{@"name": @"法币账户",@"type": @"otc"},@{@"name": @"股票账户",@"type": @"stock"}];
    }
    return self;
}

-(NSArray *)getAccounts{
    return self.accounts;
}

-(NSArray*)getAccountsNames{
    NSMutableArray * mut = @[].mutableCopy;
    for (NSDictionary * dic in self.accounts) {
        [mut addObject:dic[@"name"]];
    }
    return mut;
}

@end
