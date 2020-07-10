//
//  TAAlarmPhones.h
//  JLGP
//
//   10/18.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TAHappinessAbsorbing;

@protocol TAAlarmPhonesDelegate <NSObject>

-(void)TAAlarmPhones_hideChatViewClick;

@end

@interface TAAlarmPhones : UIView

@property (nonatomic, weak) id<TAAlarmPhonesDelegate> delegate;

@property (nonatomic, strong) TAHappinessAbsorbing * orderInfoModel;

@end

NS_ASSUME_NONNULL_END
