//
//  CAToast.h
//  JLGP
//
//  Created by  on 2019/11/13.
//  Copyright © 2019 CA. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAToast : NSObject

+(instancetype)defaultToast;

-(void)showMessage:(NSString*)msg;

@end

NS_ASSUME_NONNULL_END
