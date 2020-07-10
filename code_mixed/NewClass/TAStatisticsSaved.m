//
//  TAStatisticsSaved.m
//  JLGP
//
//  Created by  on 2019/12/10.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAStatisticsSaved.h"
//#import <Lottie/Lottie.h>

@interface TAStatisticsSaved()

//@property (nonatomic, strong) LOTAnimationView * loading;

@end

@implementation TAStatisticsSaved

+(instancetype)shareLoading{
    static dispatch_once_t onceToken;
    static TAStatisticsSaved * loading = nil;
    dispatch_once(&onceToken, ^{
        loading = [TAStatisticsSaved new];
    });
    return loading;
}

//-(LOTAnimationView *)loading{
//    if (!_loading) {
//        _loading = [LOTAnimationView animationNamed:@"nd_middle_bg"];
//        _loading.loopAnimation = YES;
//        [[UIApplication sharedApplication].delegate.window addSubview:_loading];
//        [_loading mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.centerY.equalTo([UIApplication sharedApplication].delegate.window);
//            make.width.height.equalTo(@60);
//        }];
//    }
//    return _loading;
//}

-(void)startLoading{
//    [self.loading play];
}
-(void)stopLoading{
//    [self.loading stop];
}

+(void)startLoading{

    [[TAStatisticsSaved shareLoading] startLoading];
}
+(void)stopLoading{
    
    [[TAStatisticsSaved shareLoading] stopLoading];
}

@end
