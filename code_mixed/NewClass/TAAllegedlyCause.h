//
//  TAAllegedlyCause.h
//  JLGP
//
//  Created by  on 2020/1/8.
//  Copyright © 2020 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAAllegedlyCause : UIAlertView

+ (id)showAlertWithTitle:(NSString *)title
          message:(NSString *)message
        completionBlock:(void (^)(NSUInteger buttonIndex, TAAllegedlyCause *alertView))block
cancelButtonTitle:(NSString *)cancelButtonTitle
otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end

NS_ASSUME_NONNULL_END
