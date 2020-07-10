//
//  CADealTableViewCell.h
//  JLGP
//
//  Created by ZEMac on 2019/9/10.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CADealTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary * dealData;

-(void)setTitleStyle:(NSString*)ask_code bid_code:(NSString*)bid_code;

@end

NS_ASSUME_NONNULL_END
