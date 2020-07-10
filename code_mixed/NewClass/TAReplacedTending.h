//
//  TAReplacedTending.h
//  JLGP
//
//  Copyright © 2019 CA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAFrontFriends.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAReplacedTending : NSObject

+(TAFrontFriends*)initImageMessage:(UIImage*)originImage imageMessageModel:(TAFrontFriends*)model;

+ (CGSize)caculateImageSize:(CGSize)imageSize;

+ (NSString*)removeEmoji:(NSString*)text;

@end

NS_ASSUME_NONNULL_END
