//
//  TATheseTakes.h
//  JLGP
//
//   9/18.
//  Copyright © 2019 CA. All rights reserved.
//


#import "TASuburbanTrain.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TATheseTakesDelegate <NSObject>

-(void)cellDidSelected:(UIViewController*)controller;

-(void)gotoLoginController;

-(void)shareApp;
-(void)contactUsClick;
@end

@interface TATheseTakes : TASuburbanTrain

@property (nonatomic, weak) id<TATheseTakesDelegate> delegata;

@end

NS_ASSUME_NONNULL_END
