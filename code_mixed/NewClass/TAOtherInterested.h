//
//  TAOtherInterested.h
//  JLGP
//
//   10/14.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TASorrowPress.h"
NS_ASSUME_NONNULL_BEGIN

@interface TAOtherInterested : UIView

@property (nonatomic, strong) NSArray <TASorrowPress*>* dataSourceArray;

@property (nonatomic, assign) BOOL isLoadingData;

-(void)setStateToIdle;

-(void)noMoreData;

-(void)endFresh;

@end

NS_ASSUME_NONNULL_END
