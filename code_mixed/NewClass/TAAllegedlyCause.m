//
//  TAAllegedlyCause.m
//  JLGP
//
//  Created by  on 2020/1/8.
//  Copyright © 2020 CA. All rights reserved.
//

#import "TAAllegedlyCause.h"
#import <objc/runtime.h>

@implementation TAAllegedlyCause

void EMNoTitleAlert(NSString* message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:message
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:CALanguages(@"确定")
                                          otherButtonTitles:nil];
    [alert show];
}

+ (id)showAlertWithTitle:(NSString *)title message:(NSString *)message
         completionBlock:(void (^)(NSUInteger buttonIndex, TAAllegedlyCause *alertView))block
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (!cancelButtonTitle && !otherButtonTitles) {
        return nil;
    }
    TAAllegedlyCause *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                         completionBlock:block
                                       cancelButtonTitle:cancelButtonTitle
                                       otherButtonTitles:nil];
    
    if (otherButtonTitles != nil) {
        id eachObject;
        va_list argumentList;
        if (otherButtonTitles) {
            [alertView addButtonWithTitle:otherButtonTitles];
            va_start(argumentList, otherButtonTitles);
            while ((eachObject = va_arg(argumentList, id))) {
                [alertView addButtonWithTitle:eachObject];
            }
            va_end(argumentList);
        }
    }
    
    [alertView show];
    
    return alertView;
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^block)(NSUInteger buttonIndex, UIAlertView *alertView) = objc_getAssociatedObject(self, "blockCallback");
    if (block) {
        block(buttonIndex, self);
    }
}


- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
    completionBlock:(void (^)(NSUInteger buttonIndex, TAAllegedlyCause *alertView))block
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    objc_setAssociatedObject(self, "blockCallback", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (self = [self initWithTitle:title
                           message:message
                          delegate:self
                 cancelButtonTitle:nil
                 otherButtonTitles:nil]) {
        
        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
            self.cancelButtonIndex = [self numberOfButtons] - 1;
        }
        
        id eachObject;
        va_list argumentList;
        if (otherButtonTitles) {
            [self addButtonWithTitle:otherButtonTitles];
            va_start(argumentList, otherButtonTitles);
            while ((eachObject = va_arg(argumentList, id))) {
                [self addButtonWithTitle:eachObject];
            }
            va_end(argumentList);
        }
    }
    return self;
}

@end
