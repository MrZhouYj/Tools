//
//  TAChainsSuccessful.h
//  JLGP
//
 
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAFrontFriends.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAChainsSuccessful : UITableViewCell

@property(nonatomic,strong) TAFrontFriends * messageModel;

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UIImageView *messageBackgroundImageView;

@end

NS_ASSUME_NONNULL_END
