//
//  CAChatBoxMoreView.h
//  JLGP
//
//  Created by  on 2019/10/31.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CAChatBoxMoreViewActionType){
    CAChatBoxMoreViewActionTypeAlbum = 1,
    CAChatBoxMoreViewActionTypeCamera,
};

@protocol CAChatBoxMoreViewDelegate <NSObject>

-(void)CAChatBoxMoreViewActionType_didSelectItem:(CAChatBoxMoreViewActionType)type;

@end

@interface CAChatBoxMoreView : UIView

@property (nonatomic, weak) id<CAChatBoxMoreViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
