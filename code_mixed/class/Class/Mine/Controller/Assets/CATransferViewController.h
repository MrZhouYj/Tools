//
//  CATransferViewController.h
//  JLGP
//
//  Created by  on 2020/6/22.
//  Copyright © 2020 CA. All rights reserved.
//

#import "CABaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CATransferViewController : CABaseViewController

@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * accountType;


@end

NS_ASSUME_NONNULL_END
