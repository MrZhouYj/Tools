//
//  TAEverythingHostels.m
//  JLGP
//
//  Created by ZEMac on 2020/2/4.
//  Copyright © 2020 CA. All rights reserved.
//

#import "TAEverythingHostels.h"
#import "TACitiesHeartaches.h"

@interface TAEverythingHostels()

@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * unitLabel;
@property (nonatomic, strong) UILabel * numberLabel;
@property (nonatomic, strong) TACitiesHeartaches * signButton;
@end

@implementation TAEverythingHostels

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
    
    UILabel * priceLabel = [UILabel new];
    [self.contentView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    priceLabel.font =   FONT_SEMOBOLD_SIZE(27);
    priceLabel.textColor = HexRGB(0x006cdb);
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    
    
    UILabel * unitNotiLabel = [UILabel new];
    [self.contentView addSubview:unitNotiLabel];
    unitNotiLabel.font = FONT_MEDIUM_SIZE(13);
    unitNotiLabel.textColor = HexRGB(0x9192b1);
    [unitNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel.mas_left);
        make.top.equalTo(priceLabel.mas_bottom).offset(10);
    }];
    
    
    UILabel * unitLabel = [UILabel new];
    [self.contentView addSubview:unitLabel];
    self.unitLabel = unitLabel;
    unitLabel.font = FONT_MEDIUM_SIZE(13);
    unitLabel.textColor = HexRGB(0x191d26);
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(unitNotiLabel);
        make.left.equalTo(unitNotiLabel.mas_right).offset(15);
    }];
    
    
    
    UILabel * numberNotiLabel = [UILabel new];
    [self.contentView addSubview:numberNotiLabel];
    numberNotiLabel.font = FONT_MEDIUM_SIZE(13);
    numberNotiLabel.textColor = HexRGB(0x9192b1);
    [numberNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel.mas_left);
        make.top.equalTo(unitNotiLabel.mas_bottom).offset(5);
    }];
    
    
    UILabel * numberLabel = [UILabel new];
    [self.contentView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    numberLabel.font = FONT_MEDIUM_SIZE(13);
    numberLabel.textColor = HexRGB(0x191d26);
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(numberNotiLabel);
        make.left.equalTo(numberNotiLabel.mas_right).offset(15);
    }];
    
    
    TACitiesHeartaches * signButton = [self creatButton:@"BTC" image:@"order_money_type" imageSize:CGSizeZero space:5];
    [self.contentView addSubview:signButton];
    self.signButton = signButton;
    signButton.titleLabel.textColor = HexRGB(0x191d26);
    signButton.titleLabel.font = FONT_MEDIUM_SIZE(11);
    [signButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(numberNotiLabel.mas_bottom);
        make.width.equalTo(@31);
        make.height.equalTo(@50);
    }];
    
    unitNotiLabel.text = CALanguages(@"单价");
    numberNotiLabel.text = CALanguages(@"数量") ;
    
}

-(TACitiesHeartaches*)creatButton:(NSString*)title image:(NSString*)image imageSize:(CGSize)size space:(CGFloat)space{
    
    TACitiesHeartaches * contactButton = [TACitiesHeartaches new];
    
    contactButton.imageView.image = IMAGE_NAMED(image);
    contactButton.titleLabel.font = FONT_REGULAR_SIZE(12);
    contactButton.titleLabel.textColor = [UIColor whiteColor];
    contactButton.titleLabel.text = CALanguages(title);
    [contactButton layoutWithImageSize:size space:space style:TACitiesHeartachesStyleTop];
    
    return contactButton;
}

-(void)setOrderInfoModel:(TAHappinessAbsorbing *)orderInfoModel{
    _orderInfoModel = orderInfoModel;
    
    if (orderInfoModel.fiat_amount.length&&orderInfoModel.currency_code.length) {
        self.priceLabel.text = [NSStringFormat(@"%@",orderInfoModel.fiat_amount) formatterDecimalString];
        self.unitLabel.text  = [NSStringFormat(@"%@",orderInfoModel.current_unit_price) formatterDecimalString];
        self.numberLabel.text= NSStringFormat(@"%@ %@",orderInfoModel.currency_amount,[orderInfoModel.currency_code uppercaseString]);
        [self.signButton.imageView loadImage:orderInfoModel.currency_icon];
        self.signButton.titleLabel.text = [orderInfoModel.currency_code uppercaseString];
    }
    
    
}

@end
