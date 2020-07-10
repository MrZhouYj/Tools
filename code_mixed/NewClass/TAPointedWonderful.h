//
//  TAPointedWonderful.h
//  JLGP
//
//   10/21.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TAPointedWonderfulDelegate <NSObject>

-(void)TAPointedWonderful_didSelectIndex:(NSInteger)index;

@end

@interface TAPointedWonderful : UIView

@property (nonatomic, weak) id<TAPointedWonderfulDelegate> delegata;

@property (nonatomic, assign) NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
