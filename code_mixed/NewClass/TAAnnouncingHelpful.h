//
//  TAAnnouncingHelpful.h
//  JLGP
//
//   9/16.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAGuardIsland.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TAAnnouncingHelpfulDelegate <NSObject>

-(void)tableViewDidSelectedCell:(TAAmericaStudy*)model;

@end

@interface TAAnnouncingHelpful : TAGuardIsland

@property (nonatomic, weak) id<TAAnnouncingHelpfulDelegate> delegata;

@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, assign) BOOL ignoreScrollDelegate;

@property (nonatomic, assign) BOOL tableViewCanScroll;
//目前必须设置的一个属性
@property (nonatomic, assign) int tableViewCellStyle;
@property (nonatomic, assign) BOOL showInHome;

-(void)hideEmptyView;

@end

NS_ASSUME_NONNULL_END
