//
//  TAWiresAppealing.h
//  JLGP
//
 
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TAWiresAppealing;

typedef NS_ENUM(NSInteger, TAWiresAppealingState){
    TAWiresAppealingKeyBoard,
    TAWiresAppealingMore,
    TAWiresAppealingNone,//正常状态
};

@protocol CAChatBoxDelegate <NSObject>

@optional;
/**
 *  发送文本消息
 */
- (void)chatBox:(TAWiresAppealing *)chatBox sendTextMessage:(NSString *)textMessage;
/**
 *  发送图片消息
 */
- (void)chatBox:(TAWiresAppealing *)chatBox sendImageMessage:(UIImage *)imageMessage;

- (void)chatBox:(TAWiresAppealing *)chatBox changeChatBoxHeight:(CGFloat)height;

@end

@interface TAWiresAppealing : UIView

@property (nonatomic, assign) id<CAChatBoxDelegate>delegate;

@property (nonatomic,weak) UIViewController  *viewController; 

@property (nonatomic, assign) CGFloat curHeight;

@property (nonatomic, assign) TAWiresAppealingState state;

@end

NS_ASSUME_NONNULL_END
