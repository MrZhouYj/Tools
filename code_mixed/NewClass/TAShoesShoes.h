//
//  TAShoesShoes.h
//  JLGP
//
//   10/14.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TASuburbanTrain.h"

NS_ASSUME_NONNULL_BEGIN
@class TAShoesShoes;
@protocol TAShoesShoesDelegate <NSObject>

-(void)creatOrderClick:(NSString*)order_price order_amount:(NSString*)order_amount originDictinary:(NSDictionary*)originDictionary orderView:(TAShoesShoes*)orderView;

@end

@interface TAShoesShoes : TASuburbanTrain

@property (nonatomic, weak) id<TAShoesShoesDelegate> dele;

@property (nonatomic, strong) NSDictionary * originDictionary;

@property (nonatomic, copy) NSString * order_price;

@property (nonatomic, copy) NSString * order_amount;

@end

NS_ASSUME_NONNULL_END
