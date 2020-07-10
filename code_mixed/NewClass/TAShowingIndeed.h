//
//  TAShowingIndeed.h
//  JLGP
//
//   9/26.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TAShowingIndeed;

typedef enum {
    TAShowingIndeedLayoutCenter =0,
    TAShowingIndeedLayoutBetween
}TAShowingIndeedLayout;

@protocol TAShowingIndeedDelegata <NSObject>

-(void)TAShowingIndeed_didChangeRowState:(int)state rowView:(TAShowingIndeed*)rowView;

@end

@interface TAShowingIndeed : UIView

@property (nonatomic, weak) id<TAShowingIndeedDelegata> delegata;

@property (nonatomic, strong) UILabel * label;

@property (nonatomic, strong) UIColor * imageTineColor;

@property (nonatomic, copy, nullable) NSString * title;

@property (nonatomic, copy) NSString * upTitle;

@property (nonatomic, copy) NSString * downTitle;

@property (nonatomic, strong) UIColor * titleColor;

@property (nonatomic, strong) UIFont * titleFont;

@property (nonatomic, strong) UIColor * placeHolderColor;

@property (nonatomic, strong) UIColor * borderNormalColor;

@property (nonatomic, strong) UIColor * backGroundNormalColor;

@property (nonatomic, strong) UIColor * backGroundSelectColor;

@property (nonatomic, strong) UIColor * borderSelectColor;

@property (nonatomic, strong) UIColor * selectColor;

@property (nonatomic, copy) NSString * placeHolder;

@property (nonatomic, assign) TAShowingIndeedLayout  layOut;

@property (nonatomic, assign, getter=isUp) BOOL up;

@property (nonatomic, assign) BOOL rowHidden;

@end

NS_ASSUME_NONNULL_END
