//
//  TAMomentsCustoms.h
//  JLGP
//
//  Created by  on 2019/12/11.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAMomentsCustoms : UIView

@property (nonatomic,copy) NSString * lokedText;
@property (nonatomic,copy) NSString * currencyNameText;
@property (nonatomic,copy) NSString * currencyMoneyText;
@property (nonatomic,copy) NSString * useText;

@property (nonatomic, assign) BOOL is_depositable;
@property (nonatomic, assign) BOOL is_withdrawable;
@property (nonatomic, assign) BOOL is_transferable;


@end

NS_ASSUME_NONNULL_END
