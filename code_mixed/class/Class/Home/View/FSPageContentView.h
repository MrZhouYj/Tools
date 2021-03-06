//
//  FSPageContentView.h
//  Huim
//
//  Created by huim on 2017/4/28.
//  Copyright © 2017年 huim. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSPageContentView;

@protocol FSPageContentViewDelegate <NSObject>

@optional

/**
 FSPageContentView开始滑动

 @param contentView FSPageContentView
 */
- (void)FSContentViewWillBeginDragging:(FSPageContentView *)contentView;

/**
 FSPageContentView滑动调用

 @param contentView FSPageContentView
 @param startIndex 开始滑动页面索引
 @param endIndex 结束滑动页面索引
 @param progress 滑动进度
 */
- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress;
/**
 FSPageContentView滑动调用

 @param contentView FSPageContentView
 @param index 当前滑动到哪个index
 */
- (void)FSContentViewDidScroll:(FSPageContentView *)contentView index:(NSInteger)index;
/**
 FSPageContentView结束滑动

 @param contentView FSPageContentView
 @param startIndex 开始滑动索引
 @param endIndex 结束滑动索引
 */
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

@end

@interface FSPageContentView : UIView

/**
 对象方法创建FSPageContentView

 @param frame frame
 @param delegate delegate
 @return FSPageContentView
 */
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<FSPageContentViewDelegate>)delegate;

@property (nonatomic, weak) id<FSPageContentViewDelegate>delegate;

/**
 设置contentView当前展示的页面索引，默认为0
 */
@property (nonatomic, assign) NSInteger contentViewCurrentIndex;

/**
 设置contentView能否左右滑动，默认YES
 */
@property (nonatomic, assign) BOOL contentViewCanScroll;

@property (nonatomic, strong) NSArray *childsViews;//子视图数组

@end
