//
//  TALocksNoting.h
//  JLGP
//
//  Created by  on 2019/10/31.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TALocksNotingActionType){
    TALocksNotingActionTypeAlbum = 1,
    TALocksNotingActionTypeCamera,
};

@protocol TALocksNotingDelegate <NSObject>

-(void)TALocksNotingActionType_didSelectItem:(TALocksNotingActionType)type;

@end

@interface TALocksNoting : UIView

@property (nonatomic, weak) id<TALocksNotingDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
