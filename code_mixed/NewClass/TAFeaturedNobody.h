//
//  TAFeaturedNobody.h
//  JLGP
//
//   10/18.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TASuburbanTrain.h"

NS_ASSUME_NONNULL_BEGIN
@class TAAmericaStudy;
@protocol TAFeaturedNobodyDelegate <NSObject>

- (void)TAFeaturedNobody_didsectedMarket:(TAAmericaStudy*)model;

@end

@interface TAFeaturedNobody : TASuburbanTrain

@property (nonatomic, weak) id<TAFeaturedNobodyDelegate> delegata;

@property (nonatomic, strong) NSDictionary * content;

-(void)reloadData;

-(void)didChange;

@end

NS_ASSUME_NONNULL_END
