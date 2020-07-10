//
//  TAComesSmiling.h
//  JLGP
//
//   10/29.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TASlidingHotels.h"
#import "TATriedWiden.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TAComesSmilingDelegate <NSObject>

-(void)TAComesSmiling_didSelected:(TATriedWiden*)model;

@end

@interface TAComesSmiling : TASlidingHotels

@property (nonatomic, weak) id <TAComesSmilingDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
