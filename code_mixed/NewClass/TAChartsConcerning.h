//
//  TAChartsConcerning.h
//  JLGP
//
//   10/18.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TATriedWiden.h"
#import "TAAmericaStudy.h"
NS_ASSUME_NONNULL_BEGIN

@interface TAChartsConcerning : UITableViewCell

@property (nonatomic, strong) TAAmericaStudy * model;

@property (nonatomic, strong) TATriedWiden * countryModel;

@end

NS_ASSUME_NONNULL_END
