//
//  TASweetWatching.m
//  JLGP
//
//  Created by ZEMac on 2020/2/4.
//  Copyright © 2020 CA. All rights reserved.
//

#import "TASweetWatching.h"

@implementation TASweetWatching

+(instancetype)modelWithleftTitle:(NSString *)leftTitle rightContent:(NSString *)rightContent showRow:(BOOL)showRow enableCopy:(BOOL)enableCopy{
    
    TASweetWatching * model = [TASweetWatching new];
    
    model.leftTitle = leftTitle;
    model.rightContentText = rightContent;
    model.showRow = showRow;
    model.enableCopy = enableCopy;
    
    return model;
}

@end
