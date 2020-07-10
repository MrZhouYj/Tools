
//
//  CAShowMessage.m
//  JLGP
//
//  Created by  on 2019/11/13.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAStreetsJumps.h"
#import <Toast.h>
#import "AppDelegate.h"

@interface TAStreetsJumps()

@end

@implementation TAStreetsJumps

+(instancetype)defaultToast{
    
    static TAStreetsJumps *toast = nil;
    if (!toast) {
        toast = [[TAStreetsJumps alloc] init];
        
        CSToastStyle * style = [CSToastManager sharedStyle];
        style.cornerRadius = 2;
        
        [CSToastManager setDefaultPosition:CSToastPositionCenter];
        [CSToastManager setDefaultDuration:3];
        [CSToastManager setSharedStyle:style];
    }
    
    return toast;
}

-(void)showMessage:(NSString *)msg{
    if (msg.length) {
        [[AppDelegate shareAppDelegate].window makeToast:msg];
    }
}

@end
