//
//  CAFreshTableView.h
//  JLGP
//
//  Created by  on 2019/12/9.
//  Copyright © 2019 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAFreshTableView : UITableView

-(void)addReFreshHeader:(void(^)(void))block;

-(void)addReFreshFooter:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
