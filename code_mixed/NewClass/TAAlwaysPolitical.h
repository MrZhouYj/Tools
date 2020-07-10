//
//  TAAlwaysPolitical.h
//  JLGP
//
//   10/15.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAHappinessAbsorbing.h"
NS_ASSUME_NONNULL_BEGIN

@interface TAAlwaysPolitical : UIView

@property (nonatomic, strong) TAHappinessAbsorbing * orderInfoModel;

@property (nonatomic, assign) NSInteger unreadMessagesCount;

@end

NS_ASSUME_NONNULL_END
