//
//  TADreamsFollow.h
//  JLGP
//
//   9/19.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAPremisesTaking.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TADreamsFollowDelegate <NSObject>

-(void)bitListViewDidSelectedIndex:(NSInteger)index;

@end

@interface TADreamsFollow : TAPremisesTaking

@property (nonatomic, weak) id<TADreamsFollowDelegate> delegate;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSArray * bitListDataArray;

@end

NS_ASSUME_NONNULL_END
