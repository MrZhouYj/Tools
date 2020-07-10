//
//  TAImportanceSmiling.h
//  JLGP
//
//   10/25.
//  Copyright © 2019 CA. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const TAImportanceSmilingSendMessageSuccess;

typedef enum {
    TAImportanceSmilingLogin=1,//登录页面
    TAImportanceSmilingLeftBigImageType,
    TAImportanceSmilingLeftNotiRightNotiType,
    TAImportanceSmilingOther//
}TAImportanceSmilingType;
typedef enum {
    TAImportanceSmilingContentNone=0,
    TAImportanceSmilingContentPhoneType,
    TAImportanceSmilingContentEmailType,
    TAImportanceSmilingContentTypeOther//
}TAImportanceSmilingContentType;

@interface TAImportanceSmiling : UIView

@property (nonatomic, assign) TAImportanceSmilingContentType contentType;

@property (nonatomic, strong) UITextField * inputView;

@property (nonatomic, strong) UILabel * notiLabel;

@property (nonatomic, strong) UIColor * notiLabelNormalColor;

@property (nonatomic, strong) UILabel * rightNotiLabel;

@property (nonatomic, strong) UIImageView * leftBigImageView;

@property (nonatomic, strong) UIView * leftView;

@property (nonatomic, strong) UILabel * chooseCountryLabel;

@property (nonatomic, strong) UIButton * sendButton;

@property (nonatomic, strong) UIView * rightView;

@property (nonatomic, copy) NSString * sendTitle;

@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, assign) BOOL needCheck;

@property (nonatomic, copy) NSString* maxNumber;
@property (nonatomic, copy) NSString* minNumber;

@property (nonatomic, copy) NSString * country_code;

@property (nonatomic, copy) NSString * mobile;

@property (nonatomic, copy) NSString * send_sms_key;

/**请求发短信的 接口url*/
@property (nonatomic, copy) NSString * requestUrl;

+(instancetype)showWithType:(TAImportanceSmilingType)type;

+(instancetype)showLoginTypeInputView;

-(void)setSendEnable:(BOOL)isEnable;

-(void)startSendMessageWithGT3Result:(NSDictionary*)result;

-(void)textFieldDidChange;

@end
