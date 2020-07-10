//
//  TAChancesRemarks.m
//  JLGP
//

#import "TAChancesRemarks.h"
#import "TAImportanceSmiling.h"
#import "TAAreasCalled.h"
#import "TAAccessNation.h"

@interface TAChancesRemarks ()
{
    NSString * currentAccountType;
    NSArray * list;
    NSInteger _currencyIndex;
    UILabel * currencyButton;
    NSString * fromType;
    NSString * toType;
    UILabel * unitLabel;
    UILabel * balanceLabel;
    
    BOOL isFirstAccount;
}
@property (nonatomic, strong) UILabel * fromLabel;
@property (nonatomic, strong) UILabel * toLabel;

@property (nonatomic, copy) NSString * currencyCode;

@property (nonatomic, strong) TATheirOurselves * saveButton;

@property (nonatomic, strong) TAImportanceSmiling * amountTf;
@property (nonatomic, strong) NSArray * currencyModels;
@property (nonatomic, strong) NSArray * currencyArray;
@property (nonatomic, strong) NSArray * accounts;

@property (nonatomic, strong) TAAccessNation * currentAccount;

@end

@implementation TAChancesRemarks

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bigNavcTitle = @"划转";
    
    [self setupUI];
    [self changeAccount];
}

-(NSArray *)accounts{
    if (!_accounts) {
        _accounts = [[TACarryWhich shareAccouts] getAccounts];
    }
    return _accounts;
}

-(NSArray *)currencyArray{
    _currencyArray = [TAAccessNation getCodeBigArray:self.currencyModels];
    return _currencyArray;
}
-(void)getAsset{
    
    if (!currentAccountType.length) {
        return;
    }

    NSDictionary * para = @{
        @"account_type": currentAccountType
    };
    [SVProgressHUD show];
    [TACrimeStudy GET:CAAPI_MINE_ASSET parameters:para success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] integerValue]==20000) {
            NSDictionary * data = responseObject[@"data"];
            self.currencyModels = [TAAccessNation getModels:data[@"list"]];
            [self changeCode];
        }else{
            Toast(responseObject[@"message"]);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

-(void)transferAction{
    [SVProgressHUD show];
    NSDictionary * para = @{
        @"from_account_type":currentAccountType,
        @"code": self.code,
        @"amount": self.amountTf.inputView.text,
    };
     [TACrimeStudy POST:CAAPI_MINE_ACCOUNT_TRANSFER parameters:para success:^(id responseObject) {
         [SVProgressHUD dismiss];
         Toast(responseObject[@"message"]);
         if ([responseObject[@"code"] integerValue]==20000) {
             [self.navigationController popViewControllerAnimated:YES];
         }
     } failure:^(NSError *error) {
         [SVProgressHUD dismiss];
     }];
}

-(void)routerEventWithName:(NSString *)eventName userInfo:(id)userInfo{
    if ([eventName isEqualToString:@"textFieldDidChange"]) {
        [self canTransfer];
    }
}

-(void)canTransfer{
    NSString * text = self.amountTf.inputView.text;
    if (!text.length) {
        text = @"0";
    }
    CGFloat amount = [text floatValue];
    if (amount>0) {
        self.saveButton.enabled = YES;
    }else{
        self.saveButton.enabled = NO;
    }
}

-(void)allBtnClick{
    self.amountTf.inputView.text = [NSString stringWithFormat:@"%@",_currentAccount.balance];
    [self canTransfer];
}

-(void)changeCode{
    BOOL isIn = false;
    if (self.code.length) {
        for (NSInteger i=0; i<self.currencyModels.count; i++) {
            TAAccessNation * model  =self.currencyModels[i];
            if ([model.code_big isEqualToString:[self.code uppercaseString]]) {
                isIn = YES;
                _currencyIndex = i;
                self.currentAccount = model;
                break;
            }
        }
    }
    if (!isIn) {
        self->_currencyIndex = 0;
        self.currentAccount = self.currencyModels.firstObject;
        self.code = self.currentAccount.code_big;
    }
}

-(void)chooseCurrency{
    
    [TAAreasCalled showActionSheet:self.currencyArray selectIndex:_currencyIndex click:^(NSInteger index) {
        self->_currencyIndex = index;
        self.currentAccount = self.currencyModels[index];
        self.code = self.currentAccount.code_big;
    }];
}

-(void)setCurrentAccount:(TAAccessNation *)currentAccount{
    _currentAccount = currentAccount;
    [currencyButton setText:_currentAccount.code_big];
    unitLabel.text = _currentAccount.code_big;
    balanceLabel.text = [NSString stringWithFormat:@"%@ %@",CALanguages(@"可用"),_currentAccount.balance ];
    self.amountTf.maxNumber= _currentAccount.balance;
}

-(void)setAccountType:(NSString *)accountType{
    _accountType = accountType;
    if (accountType.length) {
        isFirstAccount = [accountType isEqualToString:[self.accounts.firstObject objectForKey:@"type"]];
    }else{
        isFirstAccount = YES;
    }
}

-(void)changeAccount{
    
    if (isFirstAccount) {
        self.fromLabel.text = CALanguages([self.accounts.firstObject objectForKey:@"name"]);
        self.toLabel.text = CALanguages([self.accounts.lastObject objectForKey:@"name"]);
        currentAccountType = [self.accounts.firstObject objectForKey:@"type"];
    }else{
        self.fromLabel.text = CALanguages([self.accounts.lastObject objectForKey:@"name"]);
        self.toLabel.text = CALanguages([self.accounts.firstObject objectForKey:@"name"]);
        currentAccountType = [self.accounts.lastObject objectForKey:@"type"];
    }
    isFirstAccount = !isFirstAccount;
    
    [self getAsset];
}

-(void)setupUI{

    UIView * accountContent = [UIView new];
    [self.contentView addSubview:accountContent];
    
    accountContent.layer.borderColor = HexRGB(0xededed).CGColor;
    accountContent.layer.borderWidth = 1;
    accountContent.layer.cornerRadius = 5;
    accountContent.layer.masksToBounds = YES;
    [accountContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.top.equalTo(self.contentView).offset(25);
        make.height.equalTo(@100);
    }];
    
    self.fromLabel = [self getAccountView:YES superView:accountContent];
    self.toLabel = [self getAccountView:NO superView:accountContent];
    
    UIView * rightContent = [UIView new];
    [accountContent addSubview:rightContent];
    rightContent.backgroundColor = HexRGB(0xededed);
    [rightContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(accountContent);
        make.top.bottom.equalTo(accountContent);
        make.width.equalTo(@60);
    }];
    
    UIButton *full = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightContent addSubview:full];
    [full loadSvgImage:@"qiehuan.svg" forState:UIControlStateNormal];
    [full mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rightContent);
        make.centerX.equalTo(rightContent);
        make.width.height.equalTo(@40);
    }];
    [full setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [full addTarget:self action:@selector(changeAccount) forControlEvents:UIControlEventTouchUpInside];
        
    UIView * lineView = [self getLineView];
    [accountContent addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountContent).offset(36);
        make.centerY.equalTo(accountContent);
        make.right.equalTo(rightContent.mas_left);
        make.height.equalTo(@1);
    }];
    
    UILabel * currencyNotiLabel = [UILabel new];
    [self.contentView addSubview:currencyNotiLabel];
    currencyNotiLabel.text = CALanguages(@"币种");
    currencyNotiLabel.font = FONT_REGULAR_SIZE(14);
    currencyNotiLabel.textColor = HexRGB(0x1B1C1D);
    [currencyNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountContent);
        make.top.equalTo(accountContent.mas_bottom).offset(30);
    }];
    
    UIButton * rightRow = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:rightRow];
    [rightRow setImage:IMAGE_NAMED(@"arrowright") forState:UIControlStateNormal];
    rightRow.imageView.contentMode = UIViewContentModeScaleAspectFit;
    rightRow.enabled = NO;
    rightRow.tintColor = HexRGB(0xc5c9db);
    [rightRow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-25);
        make.top.equalTo(currencyNotiLabel.mas_bottom).offset(20);
        make.width.equalTo(@10);
        make.height.equalTo(@12);
    }];
    
   
    currencyButton = [UILabel new];
    [self.contentView addSubview:currencyButton];
    currencyButton.userInteractionEnabled = YES;
    currencyButton.font = FONT_MEDIUM_SIZE(16);
    [currencyButton setTextColor:HexRGB(0x1B1C1D)];
    [currencyButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseCurrency)]];
    [currencyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rightRow);
        make.left.equalTo(accountContent.mas_left);
        make.height.equalTo(@35);
        make.right.equalTo(rightRow.mas_left);
    }];
    
    UIView * line1 = [self getLineView];
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountContent);
        make.top.equalTo(currencyButton.mas_bottom).offset(5);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@1);
    }];
    
   
    
    self.amountTf = [TAImportanceSmiling showLoginTypeInputView];
    self.amountTf.notiLabel.text = CALanguages(@"数量");
    [self.contentView addSubview:self.amountTf];
    self.amountTf.notiLabelNormalColor = HexRGB(0x1B1C1D);
    self.amountTf.notiLabel.font = FONT_REGULAR_SIZE(14);
    [self.amountTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(line1).offset(30);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    self.amountTf.inputView.keyboardType = UIKeyboardTypeDecimalPad;
    
    UIView * amountRightView = [UIView new];
    self.amountTf.rightView = amountRightView;
    [amountRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.amountTf);
        make.centerY.equalTo(self.amountTf.inputView);
        make.width.equalTo(@80);
        make.height.equalTo(@40);
    }];

    
    UIButton * allButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [amountRightView addSubview:allButton];
    [allButton setTitle:CALanguages(@"全部") forState:UIControlStateNormal];
    allButton.titleLabel.font = FONT_MEDIUM_SIZE(14);
    allButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [allButton setTitleColor:HexRGB(0x006cdb) forState:UIControlStateNormal];
    [allButton addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(amountRightView);
        make.centerY.equalTo(amountRightView);
        make.width.equalTo(@40);
        make.height.equalTo(@30);
    }];
    
   
    
    UIView *vline = [self getLineView];
    [amountRightView addSubview:vline];
    [vline mas_makeConstraints:^(MASConstraintMaker *make) {
       make.height.equalTo(@16);
       make.centerY.equalTo(amountRightView);
       make.width.equalTo(@1);
       make.right.equalTo(allButton.mas_left).offset(-5);
    }];
    
    
    unitLabel = [UILabel new];
    [amountRightView addSubview:unitLabel];
    unitLabel.font = FONT_MEDIUM_SIZE(14);
    unitLabel.textColor = HexRGB(0xA0A4AC);
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(vline.mas_left).offset(-10);
        make.centerY.equalTo(amountRightView);
    }];
    
    balanceLabel = [UILabel new];
    [self.contentView addSubview:balanceLabel];
    balanceLabel.font = FONT_REGULAR_SIZE(12);
    balanceLabel.textColor = HexRGB(0xA0A4AC);
    [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountContent);
        make.top.equalTo(self.amountTf.mas_bottom).offset(5);
    }];
    
    
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.amountTf.mas_bottom).offset(40);
    }];
    
    self.saveButton = [TATheirOurselves buttonWithTitle:@"划转"];
    [self.view addSubview:self.saveButton];
        [self.saveButton addTarget:self action:@selector(transferAction) forControlEvents:UIControlEventTouchUpInside];
    self.saveButton.layer.masksToBounds = YES;
    self.saveButton.layer.cornerRadius = 22;
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@44);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
    }];
        
}

-(UIView *)getLineView{
    UIView * lineView = [UIView new];
    lineView.backgroundColor = HexRGB(0xededed);
    return lineView;
}

-(UILabel*)getAccountView:(BOOL)isFrom superView:(UIView *)superView{
    UIView * view = [UIView new];
    [superView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.height.equalTo(superView).multipliedBy(0.5);
        make.right.equalTo(superView).offset(-60);
        if (isFrom) {
            make.top.equalTo(superView);
        }else{
            make.bottom.equalTo(superView);
        }
    }];
    
    UIView * pointView = [UIView new];
    [view addSubview:pointView];
    pointView.layer.masksToBounds = YES;
    pointView.layer.cornerRadius = 3;
    if (isFrom) {
        pointView.backgroundColor = [UIColor increaseColor];
    }else{
        pointView.backgroundColor = [UIColor decreaseColor];
    }
    [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.centerY.equalTo(view);
        make.width.height.equalTo(@6);
    }];
    
    UILabel * notiLabel = [UILabel new];
    [view addSubview:notiLabel];
    if (isFrom) {
        notiLabel.text = CALanguages(@"从");
    }else{
        notiLabel.text = CALanguages(@"到");
    }
    notiLabel.textColor = HexRGB(0xA0A4AC);
    notiLabel.font = FONT_REGULAR_SIZE(14);
    [notiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pointView.mas_right).offset(15);
        make.centerY.equalTo(pointView);
        make.width.equalTo(@50);
    }];
    
    UILabel * accountLabel = [UILabel new];
    [view addSubview:accountLabel];
    
    accountLabel.textColor = HexRGB(0x1B1C1D);
    accountLabel.font = ROBOTO_FONT_MEDIUM_SIZE(14);
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(notiLabel.mas_right).offset(10);
        make.centerY.equalTo(view);
    }];
    
    return accountLabel;
    
}

@end
