//
//  TAAboutEntertain.m
//  JLGP
//
//  Created by  on 2020/6/28.
//  Copyright © 2020 CA. All rights reserved.
//

#import "TAAboutEntertain.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>
#import "TAGoodsEvening.h"

@interface TAAboutEntertain ()

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIButton * logoutBtn;

@property (nonatomic, strong) UIImageView *agreeImageView;

@property (nonatomic, assign) BOOL is_agree;

@end

@implementation TAAboutEntertain

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadData];
}

-(void)setIs_agree:(BOOL)is_agree{
    _is_agree = is_agree;
    if (_is_agree) {
        self.agreeImageView.image = IMAGE_NAMED(@"gouxuan-xuanzhong-fangkuang");
    }else{
        self.agreeImageView.image = IMAGE_NAMED(@"gouxuan-weixuanzhong-xianxingfangkuang");
    }
}

-(void)setAgree{
    self.is_agree = !self.is_agree;
}
-(void)loadData{
    
    [SVProgressHUD show];
    [TACrimeStudy GET:CAAPI_MINE_GET_PROTOCOL_CONTENT parameters:nil success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self createUI];
        
        [self.webView loadHTMLString:[self adaptWebViewHtml:responseObject[@"data"]] baseURL:nil];
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
-(void)createUI{
    
    WKWebViewConfiguration * webConfig = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webConfig];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    [_webView sizeToFit];
    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    _webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:_webView];
    
    UILabel * agreeLabel = [UILabel new];
    [self.view addSubview:agreeLabel];
    agreeLabel.font = FONT_REGULAR_SIZE(14);
    agreeLabel.text = CALanguages(@"我已认真阅读并完全理解风险告知书及投资者须知中各条款内容，自愿申请成为投资者");
    agreeLabel.numberOfLines = 0;
    agreeLabel.textColor = RGB(0, 69, 169);
    agreeLabel.userInteractionEnabled = YES;
    
    self.agreeImageView = [UIImageView new];
    [self.view addSubview:self.agreeImageView];
    
    self.agreeImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setAgree)];
    [self.agreeImageView addGestureRecognizer:tap];
    [agreeLabel addGestureRecognizer:tap];
    
    
    _logoutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_logoutBtn];
    _logoutBtn.titleLabel.font = FONT_MEDIUM_SIZE(16);
    [_logoutBtn setTitleColor:HexRGB(0xf8fbff) forState:UIControlStateNormal];
    _logoutBtn.backgroundColor = RGB(0, 108, 219);
    _logoutBtn.layer.masksToBounds = YES;
    _logoutBtn.layer.cornerRadius = 2;
    [_logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.bottom.equalTo(self.view).offset(-(15+SafeAreaBottomHeight));
        make.height.equalTo(@45);
    }];
    [_logoutBtn addTarget:self action:@selector(agreeClick) forControlEvents:UIControlEventTouchUpInside];
    [_logoutBtn setTitle:CALanguages(@"下一步") forState:UIControlStateNormal];

    [agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(_logoutBtn.mas_top).offset(-10);
        make.left.equalTo(self.agreeImageView.mas_right).offset(5);
    }];
    
    [self.agreeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(agreeLabel.mas_top);
        make.width.height.equalTo(@20);
    }];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(agreeLabel.mas_top).offset(-10);
        make.top.equalTo(self.navcBar.mas_bottom);
    }];
    self.is_agree = NO;
}

-(void)agreeClick{
    
    if (!self.is_agree) {
        Toast(@"请先同意协议");
        return;
    }
    
    TAGoodsEvening * agent = [TAGoodsEvening new];
    [self.navigationController pushViewController:agent animated:YES];
    
}


-(NSString*)adaptWebViewHtml:(NSString*)html{
    if ([html containsString:@"<html>"]) {
        return html;
    }
    NSMutableString * headHtml = @"".mutableCopy;
    [headHtml appendString:@"<html>"];
    [headHtml appendString:@"<head>"];
    [headHtml appendString:@"<meta charset=\"utf-8\">"];
    [headHtml appendString:@"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\"/>"];
    [headHtml appendString:@"</head>"];
    [headHtml appendString:@"<body>"];
    [headHtml appendString:html];
    [headHtml appendString:@"</body>"];
    [headHtml appendString:@"</html>"];
    return  headHtml;
}


@end
