//
//  TAMaybeSeeking.m
//  JLGP
//
//  Created by  on 2019/12/19.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAMaybeSeeking.h"

@interface TAMaybeSeeking()

@property (weak, nonatomic) IBOutlet UIImageView *payIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *payNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userAccountLabel;


@end

@implementation TAMaybeSeeking

- (IBAction)activationAction:(id)sender {
    
//    [self routerEventWithName:@"activationAction" userInfo:self.key];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.payNameLabel.font = FONT_MEDIUM_SIZE(15);
    self.userNameLabel.font = FONT_MEDIUM_SIZE(15);
    self.stateLabel.font = FONT_MEDIUM_SIZE(14);
    self.userAccountLabel.font = FONT_MEDIUM_SIZE(15);
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.payIconImageView);
    }];
    [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.stateLabel.mas_left).offset(-5);
        make.centerY.equalTo(self.stateLabel);
        make.width.height.equalTo(@15);
    }];
    
}



-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    self.payNameLabel.text = NSStringFormat(@"%@",dataDic[@"payment_name"]);
}

-(void)setKey:(NSString *)key{
    _key = key;
    
    if ([key isEqualToString:Wechat_pay]) {
        self.payIconImageView.image = IMAGE_NAMED(@"WeChat");
        self.userAccountLabel.text = NSStringFormat(@"%@",self.dataDic[@"account"]);
        self.userNameLabel.text = NSStringFormat(@"%@",self.dataDic[@"real_name"]);
        
    }else if ([key isEqualToString:Bank_card_pay]){
        self.payIconImageView.image = IMAGE_NAMED(@"Bankcard");
        self.userAccountLabel.text = NSStringFormat(@"%@",self.dataDic[@"bank_account_number"]);
        self.userNameLabel.text = NSStringFormat(@"%@",self.dataDic[@"real_name"]);
        
    }else if ([key isEqualToString:Alipay]){
        self.payIconImageView.image = IMAGE_NAMED(@"Alipay");
        self.userAccountLabel.text = NSStringFormat(@"%@",self.dataDic[@"account"]);
        self.userNameLabel.text = NSStringFormat(@"%@",self.dataDic[@"real_name"]);
    }
}

@end
