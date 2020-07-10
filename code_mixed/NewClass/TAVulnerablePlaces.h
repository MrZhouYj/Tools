//
//  TAVulnerablePlaces.h
//  JLGP
//
//   10/28.
//  Copyright © 2019 CA. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TAVulnerablePlaces;
@protocol TAVulnerablePlacesDelegate <NSObject>

@required;
-(void)webSocket:(TAVulnerablePlaces *)webSocket didReceiveMessage:(NSDictionary*)message;
-(void)webSocketDidOpen;

@end

@interface TAVulnerablePlaces : NSObject

+(instancetype)shareSocket;

-(void)addDelegate:(id)delegate;
/**
 页面销毁之前 必须调用这个方法
 */
- (void)removeDelegate:(id)delegate;

- (void)connectServer;

- (void)reConnectServer;

- (void)closeConnect;

- (void)sendDataToSever:(NSDictionary*)dictionary;

- (void)unsubCurrentReq;

- (void)unsub:(NSDictionary*)dictionary;

+ (NSDictionary *)getSub:(NSDictionary*)para;

@end
