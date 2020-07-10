//
//  TAHappiestAdvisor.h
//  JLGP
//
//   9/24.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TASorrowPress.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAHappiestAdvisor : UITableViewCell

//nil  法币显示的样式 MyAdvertisementList 我的广告
@property (nonatomic, copy) NSString * action_type;

@property (nonatomic, strong) TASorrowPress * model;

+(CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
