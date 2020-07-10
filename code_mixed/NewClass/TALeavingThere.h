//
//  TALeavingThere.h
//  JLGP
//
//   10/18.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TASuburbanTrain.h"
@class TAFrontFriends;
@class TAHappinessAbsorbing;

NS_ASSUME_NONNULL_BEGIN

@interface TALeavingThere : TASuburbanTrain

@property (nonatomic,weak) UIViewController  *viewController; //-> 一定是weak

@property (nonatomic, copy) NSString * ID;
@property (nonatomic, strong) TAHappinessAbsorbing * orderInfoModel;
@property (nonatomic, assign) NSInteger unreadMessagesCount;

- (void)getMessage;

- (void)subscribeChat;

- (void)unSubscribeChat;

@end

NS_ASSUME_NONNULL_END
