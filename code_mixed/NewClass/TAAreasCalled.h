//
//  TAAreasCalled.h
//  JLGP
//
//   10/22.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TASuburbanTrain.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^Block)(id value, NSInteger index);

@interface CAActionCell : UITableViewCell

@property (nonatomic, copy) NSString * text;

@property (nonatomic, assign) BOOL isHightLight;

@end

@interface TAAreasCalled : TASuburbanTrain

+(instancetype)showActionSheet:(NSArray*)data selectIndex:(NSInteger)index click:(void (^)(NSInteger))block;

+(instancetype)showActionSheet:(NSArray*)data key:(id)key selectIndex:(NSInteger)index click:(Block)block;

@end



NS_ASSUME_NONNULL_END
