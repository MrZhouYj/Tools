//
//  TABasedSouthwest.h
//  JLGP
//
//  Created by ZEMac on 2019/9/11.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TABasedSouthwestDelegata <NSObject>
/**
 主图指标action
 */
-(void)TABasedSouthwest_didSelectedStatus:(Y_StockChartTargetLineStatus)status;
/**
  副图指标action
*/
-(void)TABasedSouthwest_didSelectedAccessoryStatus:(Y_StockChartTargetLineStatus)status;

@end

@interface TABasedSouthwest : UIView

@property (nonatomic, weak) id<TABasedSouthwestDelegata> delegata;

@property (nonatomic, assign) BOOL isFullScreen;

@end

NS_ASSUME_NONNULL_END
