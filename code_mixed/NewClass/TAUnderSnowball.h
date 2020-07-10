//
//  TAUnderSnowball.h
//  JLGP
//
//   9/16.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAAmericaStudy.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAUnderSnowball : UITableViewCell

@property (nonatomic, assign) int cellStyle;
@property (nonatomic, assign) BOOL showInHome;
@property (nonatomic, strong) TAAmericaStudy * model;

@end

NS_ASSUME_NONNULL_END
