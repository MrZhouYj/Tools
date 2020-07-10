//
//  CAAccountTotalView.m
//  JLGP
//


#import "CAAccountTotalView.h"
#import "CAButton.h"

@interface CAAccountTotalView()
{
    CAButton * transferButton;
}
@property (nonatomic, strong) UILabel * noteLabel;
@property (nonatomic, strong) UILabel * fiatLabel;

@end

@implementation CAAccountTotalView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    
    self.noteLabel = [UILabel new];
    [self addSubview:self.noteLabel];
    
    self.fiatLabel = [UILabel new];
    [self addSubview:self.fiatLabel];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(22);
    }];
    
    [self.fiatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noteLabel);
        make.top.equalTo(self.noteLabel.mas_bottom).offset(5);
    }];
    
    transferButton = [CAButton new];
    [self addSubview:transferButton];
    
    transferButton.imageView.image = IMAGE_NAMED(@"Assets");
    transferButton.titleLabel.font = FONT_REGULAR_SIZE(11);
    transferButton.titleLabel.textColor = HexRGB(0x717273);
    transferButton.titleLabel.text = CALanguages(@"资金划转");
    [transferButton layoutWithImageSize:CGSizeMake(20, 20) space:5 style:CAButtonStyleTop];
    [transferButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transferAction)]];
    
    [transferButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(25);
        make.height.equalTo(@40);
    }];
    
    UIView * lineView1 = [UIView new];
    [self addSubview:lineView1];
    lineView1.backgroundColor = HexRGB(0xF2F8F9);
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@10);
    }];
}



-(void)updateUI{
    
    NSLog(@"%@",self.otc_all_sssets);
    NSLog(@"%@",self.stock_assets);
    NSLog(@"%@",self.stock_all_sssets);
    NSLog(@"%@",self.accountType);
    
    
    if ([_accountType isEqualToString:@"otc"]) {
        self.noteLabel.font = FONT_REGULAR_SIZE(12);
        self.noteLabel.textColor = HexRGB(0x717273);
        self.fiatLabel.font = ROBOTO_FONT_MEDIUM_SIZE(18);
        
        self.noteLabel.text = CALanguages(@"法币资产估值");
        self.fiatLabel.text = [NSString stringWithFormat:@"%@",self.otc_all_sssets];
    }else if([_accountType isEqualToString:@"stock"]){
        NSString * left1 = CALanguages(@"股票资产估值");
        NSString * left2 = CALanguages(@"股票账户估值");
        NSString * value1 = self.stock_all_sssets;
        NSString * value2 = self.stock_assets;
        NSMutableAttributedString * top = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",left1,value1]];
        NSMutableAttributedString * btm = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",left2,value2]];
        
        NSDictionary * dic1 = @{
            NSFontAttributeName:FONT_REGULAR_SIZE(12),
            NSForegroundColorAttributeName: HexRGB(0x717273)
        };
        NSDictionary * dic2 = @{
            NSFontAttributeName:ROBOTO_FONT_MEDIUM_SIZE(18),
            NSForegroundColorAttributeName: [UIColor blackColor]
        };
        [top addAttributes:dic1 range:NSMakeRange(0, left1.length)];
        [top addAttributes:dic2 range:NSMakeRange(left1.length+1, value1.length)];
        [btm addAttributes:dic1 range:NSMakeRange(0, left2.length)];
        [btm addAttributes:dic2 range:NSMakeRange(left2.length+1, value2.length)];
        
        self.noteLabel.attributedText = top;
        self.fiatLabel.attributedText = btm;
        
    }else{
        self.noteLabel.text = @"";
        self.fiatLabel.text = @"";
    }
}

-(void)transferAction{
    [self routerEventWithName:@"transferAction" userInfo:nil];
}

@end
