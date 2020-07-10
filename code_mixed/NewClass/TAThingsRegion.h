//
//  TAThingsRegion.h
//  JLGP
//
//  Created by  on 2019/12/18.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TASlidingHotels.h"
#import "TAHappinessAbsorbing.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAThingsRegion : TASlidingHotels

@property (nonatomic, strong) TAHappinessAbsorbing * infoModel;

@end

NS_ASSUME_NONNULL_END
