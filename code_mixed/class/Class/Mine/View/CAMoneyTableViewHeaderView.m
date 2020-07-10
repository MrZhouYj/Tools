//
//  CAMoneyTableViewHeaderView.m
//  JLGP
//
//   9/25.
//  Copyright © 2019 CA. All rights reserved.
//

#import "CAMoneyTableViewHeaderView.h"
#import "CASegmentView.h"
#import "CAAccountTotalView.h"

@interface CAMoneyTableViewHeaderView()
<CASegmentViewDelegate>
{
    NSArray * accounts;
    NSArray * acountsNames;
}
@property (nonatomic, strong) UILabel * allMoneyLabel;
@property (nonatomic, strong) CASegmentView *segmentView;

@end

@implementation CAMoneyTableViewHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    
    accounts = [[CAAccounts shareAccouts] getAccounts];
    acountsNames = [[CAAccounts shareAccouts] getAccountsNames];
    
    UIImageView * bgImageV = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"Backgroundmap")];
    [self addSubview:bgImageV];
    [bgImageV setContentMode:UIViewContentModeScaleAspectFill];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(120);
    }];
    
    UILabel * allPriceNotiLabel = [UILabel new];
    [bgImageV addSubview:allPriceNotiLabel];
    allPriceNotiLabel.text = CALanguages(@"总资产");
    allPriceNotiLabel.font = FONT_MEDIUM_SIZE(15);
    allPriceNotiLabel.textColor = [UIColor whiteColor];
    [allPriceNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageV).offset(15);
        make.top.equalTo(bgImageV).offset(30);
    }];
 
    self.allMoneyLabel = [UILabel new];
    [bgImageV addSubview:self.allMoneyLabel];
    self.allMoneyLabel.textColor = [UIColor whiteColor];
    self.allMoneyLabel.font = ROBOTO_FONT_MEDIUM_SIZE(22);
    [self.allMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allPriceNotiLabel);
        make.top.equalTo(allPriceNotiLabel.mas_bottom).offset(15);
    }];
    
    self.segmentView = [[CASegmentView alloc] initWithFrame:CGRectMake(0, 200, MainWidth, 50)];
    [self addSubview:self.segmentView];
    self.segmentView.isFixedSpace = YES;
    self.segmentView.showBottomLine = YES;
    self.segmentView.delegata = self;
    self.segmentView.itemFont = FONT_REGULAR_SIZE(16);
    self.segmentView.backgroundColor = [UIColor whiteColor];
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(bgImageV.mas_bottom);
        make.height.equalTo(@50);
    }];
    
    self.segmentView.segmentItems = [[CAAccounts shareAccouts] getAccountsNames];
    self.segmentView.segmentCurrentIndex = 0;
    
    UIView * lineView = [UIView new];
    [self addSubview:lineView];
    lineView.backgroundColor = HexRGB(0xefefef);
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.segmentView.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView.mas_bottom);
    }];
    
}



-(void)CASegmentView_didSelectedIndex:(NSInteger)index{
    
    [self routerEventWithName:@"changeAccountType" userInfo:accounts[index]];
}

-(void)setAssets:(NSString *)assets{
    _assets = assets;
    self.allMoneyLabel.text = [NSString stringWithFormat:@"%@",assets];
}

//-(void)setTotal_in_fiat:(NSString *)total_in_fiat total_in_crypto:(NSString *)total_in_crypto{
//    NSLog(@"%@",total_in_crypto);
//    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",total_in_crypto,total_in_fiat]];
//    [attr addAttributes:@{
//        NSFontAttributeName: FONT_MEDIUM_SIZE(22)
//    } range:NSMakeRange(0, total_in_crypto.length)];
//    [attr addAttributes:@{
//        NSFontAttributeName: FONT_REGULAR_SIZE(14)
//    } range:NSMakeRange(total_in_crypto.length+1, total_in_fiat.length)];
//    self.allMoneyLabel.attributedText = attr;
//
//}



@end
