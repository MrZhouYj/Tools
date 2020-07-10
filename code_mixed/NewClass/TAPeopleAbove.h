//
//  TAPeopleAbove.h
//  JLGP
//
//   10/10.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TATrialsRelief.h"
NS_ASSUME_NONNULL_BEGIN

@interface TAPeopleAbove : UITableViewCell

@property (nonatomic, strong) TATrialsRelief * model;

+(CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
