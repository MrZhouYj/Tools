//
//  CAMoneyActionMenuView.h
//  JLGP
//
//  Created by  on 2019/11/11.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAMoneyActionMenuView : UIView

@property (nonatomic, assign) BOOL is_depositable;
@property (nonatomic, assign) BOOL is_withdrawable;
@property (nonatomic, assign) BOOL is_transferable;

-(void)languageDidChange;

@end

NS_ASSUME_NONNULL_END
