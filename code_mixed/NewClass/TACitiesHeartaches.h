//
//  TACitiesHeartaches.h
//  JLGP
//
//   10/15.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TACitiesHeartachesStyle) {
    TACitiesHeartachesStyleTop, // image在上，label在下
    TACitiesHeartachesStyleLeft, // image在左，label在右
    TACitiesHeartachesStyleBottom, // image在下，label在上
    TACitiesHeartachesStyleRight // image在右，label在左
};

@interface TACitiesHeartaches : UIView

@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, assign) TACitiesHeartachesStyle style;

@property (nonatomic, assign) BOOL isShowRedDot;


-(void)layoutWithImageSize:(CGSize)size space:(CGFloat)space style:(TACitiesHeartachesStyle)style;

@end

NS_ASSUME_NONNULL_END
