//
//  CAMoneyTableViewCell.m
//  JLGP
//
//   9/25.
//  Copyright © 2019 CA. All rights reserved.
//

#import "CAMoneyTableViewCell.h"

@interface CAMoneyTableViewCell()

@property (nonatomic, strong) UILabel * priceNameLabel;

@property (nonatomic, strong) UILabel * enableUseLabel;

@property (nonatomic, strong) UILabel * localLabel;

@property (nonatomic, strong) UILabel * hanglingLabel;

@end

@implementation CAMoneyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    
    self.priceNameLabel = [UILabel new];
    [self.contentView addSubview:self.priceNameLabel];
    
    UILabel * notiLabel = [UILabel new];
    [self.contentView addSubview:notiLabel];
    notiLabel.textColor = RGB(150, 157, 191);
    notiLabel.font = FONT_MEDIUM_SIZE(13);
    notiLabel.text = CALanguages(@"可用");
    
    self.enableUseLabel = [UILabel new];
    [self.contentView addSubview:self.enableUseLabel];
    self.enableUseLabel.textColor = RGB(13, 13, 35);
    self.enableUseLabel.font = ROBOTO_FONT_MEDIUM_SIZE(13);
    
    
    UILabel * lockNotiLabel = [UILabel new];
    [self.contentView addSubview:lockNotiLabel];
    lockNotiLabel.textColor = RGB(133, 139, 181);
    lockNotiLabel.font = FONT_MEDIUM_SIZE(13);
    lockNotiLabel.text = CALanguages(@"锁定");
    lockNotiLabel.textAlignment = NSTextAlignmentCenter;
    
    self.localLabel = [UILabel new];
    [self.contentView addSubview:self.localLabel];
    self.localLabel.textColor = RGB(133, 139, 181);
    self.localLabel.font = ROBOTO_FONT_MEDIUM_SIZE(13);
    self.localLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UILabel * hanglingNotiLabel = [UILabel new];
    [self.contentView addSubview:hanglingNotiLabel];
    hanglingNotiLabel.textColor = RGB(133, 139, 181);
    hanglingNotiLabel.font = FONT_MEDIUM_SIZE(13);
    hanglingNotiLabel.text = CALanguages(@"未成交");
    
    self.hanglingLabel = [UILabel new];
    [self.contentView addSubview:self.hanglingLabel];
    self.hanglingLabel.textColor = RGB(133, 139, 181);
    self.hanglingLabel.font = ROBOTO_FONT_MEDIUM_SIZE(13);
    self.hanglingLabel.textAlignment = NSTextAlignmentRight;
    
    
    
 
//布局
    [self.priceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.enableUseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceNameLabel.mas_left);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    [notiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.enableUseLabel.mas_left);
        make.bottom.equalTo(self.enableUseLabel.mas_top).offset(-5);
    }];
    
    [self.hanglingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.enableUseLabel);
    }];
    [hanglingNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.hanglingLabel.mas_right);
        make.centerY.equalTo(notiLabel);
        make.width.equalTo(self.hanglingLabel);
    }];
    
    [self.localLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.enableUseLabel);
    }];
    [lockNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(notiLabel);
        make.centerX.equalTo(self.localLabel);
    }];
    
    
    UIView * lineView = [UIView new];
    [self.contentView addSubview:lineView];
    lineView.dk_backgroundColorPicker = DKColorPickerWithKey(LineColor);
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.equalTo(@0.5);
    }];
    
}

-(void)setModel:(CACurrencyMoneyModel *)model{
    _model = model;
    
    NSString * mainText = model.code_big;
    NSString * subText = NSStringFormat(@" %@",model.total);
    
    NSDictionary * mut = @{
                           NSForegroundColorAttributeName:HexRGB(0x006cdb),
                           NSFontAttributeName:[UIFont boldSystemFontOfSize:17]
                           };
    NSDictionary * mut1 = @{
                            NSForegroundColorAttributeName:RGB(149,156,190),
                            NSFontAttributeName:ROBOTO_FONT_MEDIUM_SIZE(13)
                            };
    
    NSMutableAttributedString * mutAttr = [[NSMutableAttributedString alloc] initWithString:NSStringFormat(@"%@%@",mainText,subText)];
    [mutAttr addAttributes:mut range:NSMakeRange(0, mainText.length)];
    [mutAttr addAttributes:mut1 range:NSMakeRange(mainText.length, subText.length)];
    self.priceNameLabel.attributedText = mutAttr;
    self.enableUseLabel.text = NSStringFormat(@"%@",model.balance);
    self.localLabel.text = NSStringFormat(@"%@",model.locked);
    self.hanglingLabel.text = NSStringFormat(@"%@",model.handling);

   
}

@end
