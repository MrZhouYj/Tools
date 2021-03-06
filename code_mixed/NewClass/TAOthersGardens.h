//
//  TAOthersGardens.h
//  JLGP
//
//  Created by  on 2019/11/26.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAStationBehind.h"

typedef void(^ConfirmBlock)(id);
typedef void(^CancleBlock)(void);

@interface TAOthersGardens : TAStationBehind

-(void)showAlert:(NSString*)logo
           title:(NSString*)title
        subTitle:(NSString*)subTitle
       notiTitle:(NSString*)notiTitle
    confirmBlock:(ConfirmBlock)confirm
     cancleBlock:(CancleBlock)cancle;

-(void)showAlertTitle:(NSString*)title
             subTitle:(NSString*)subTitle
     importPayMethods:(NSArray*)payMethods
         confirmBlock:(ConfirmBlock)confirm
          cancleBlock:(CancleBlock)cancle;

@end
