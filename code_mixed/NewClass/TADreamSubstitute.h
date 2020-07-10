//
//  TADreamSubstitute.h
//  JLGP
//
//   9/19.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAAmericaStudy.h"

typedef enum : NSUInteger {
    AlignmentLeft,
    AlignmentCenter,
    AlignmentRight,
} Alignment;

NS_ASSUME_NONNULL_BEGIN
@class TADreamSubstitute;
@protocol TADreamSubstituteDelegate <NSObject>

-(void)notiUpDownViewDidChange:(TADreamSubstitute*)view rowState:(CASymbolsSortType)type;

@end

@interface TADreamSubstitute : UIView

@property (nonatomic, weak) id<TADreamSubstituteDelegate> delegate;

@property (nonatomic, assign) Alignment alignment;

@property (nonatomic, assign) CASymbolsSortType type;

@property (nonatomic, copy) NSString* name;

@property (nonatomic, copy) NSString* key;

@property (nonatomic, weak) void(^block)(BOOL);

@end

NS_ASSUME_NONNULL_END
