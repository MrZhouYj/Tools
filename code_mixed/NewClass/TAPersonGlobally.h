//
//  TAPersonGlobally.h
//  JLGP
//
//   9/24.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TAPersonGloballyDelegata <NSObject>

-(void)TAPersonGlobally_didSelectedIndex:(NSString*)trade_type;

@end

@interface TAPersonGlobally : UIView

@property (nonatomic, weak) id<TAPersonGloballyDelegata>delegata;

@end

NS_ASSUME_NONNULL_END
