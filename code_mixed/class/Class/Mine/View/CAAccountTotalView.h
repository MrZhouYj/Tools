//
//  CAAccountTotalView.h
//  JLGP
//
//  Created by  on 2020/6/22.
//  Copyright © 2020 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAAccountTotalView : UIView

@property (nonatomic, copy) NSString * accountType;

@property (nonatomic, copy) NSString * stock_all_sssets;
@property (nonatomic, copy) NSString * stock_assets;
@property (nonatomic, copy) NSString * otc_all_sssets;

-(void)updateUI;

@end

NS_ASSUME_NONNULL_END
