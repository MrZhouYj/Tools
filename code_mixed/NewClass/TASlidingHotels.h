//
//  TASlidingHotels.h
//  JLGP
//
//  Created by ZEMac on 2019/9/7.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAPoliceCommittee.h"

NS_ASSUME_NONNULL_BEGIN

@interface TASlidingHotels : UIViewController

@property (nonatomic, strong) UIImageView * backGroungImageView;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UILabel * bigTitleLabel;

/**自定义导航栏*/
@property (nonatomic, strong) TAPoliceCommittee * navcBar;
/**自定义导航栏标题*/
@property (nonatomic, copy) NSString * navcTitle;
/**自定义导航栏大标题*/
@property (nonatomic, copy) NSString * bigNavcTitle;
/**自定义导航栏标题颜色*/
@property (nonatomic, strong) UIColor * titleColor;
/**自定义导航栏返回按钮颜色*/
@property (nonatomic, strong) UIColor * backTineColor;

- (void)languageDidChange;
- (void)willEnterForeground;
- (void)didEnterBackground;

-(void)backAction;

@end

NS_ASSUME_NONNULL_END
