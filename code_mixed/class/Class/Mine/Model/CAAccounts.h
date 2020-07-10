//
//  CAAccounts.h
//  JLGP
//
//  Created by  on 2020/6/23.
//  Copyright © 2020 CA. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAAccounts : NSObject

+ (instancetype)shareAccouts;
- (NSArray*)getAccounts;
- (NSArray*)getAccountsNames;

@end

NS_ASSUME_NONNULL_END
