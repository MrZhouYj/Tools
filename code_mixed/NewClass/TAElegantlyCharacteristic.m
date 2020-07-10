
//
//  TAElegantlyCharacteristic.m
//  JLGP
//
//  Created by ZEMac on 2019/9/7.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAElegantlyCharacteristic.h"
#import "TAAmericanEpidemics.h"
#import "TASmallTaking.h"
#import "TANoticesTraditional.h"
#import "TAPremisesTaking.h"
#import "TAHomesMajor.h"
#import "TAAnnouncingHelpful.h"
#import "FSPageContentView.h"
#import "TASuburbanTrain.h"
#import "TATheseTakes.h"
#import "TAAlongDuring.h"
#import "TAVulnerablePlaces.h"
#import "TAPleasantOpportunity.h"
#import "TAUncommonTowels.h"
#import "TABuiltDream.h"
#import "TAStrongAsking.h"
#import "TAAppreciatePlans.h"
#import "SSGestureLockView.h"
#import "PMainThreadWatcher.h"
#import "TAAmericaStudy.h"
#import "TACompanyPrograms.h"
#import "TADoorsPlans.h"
#import "TASteelInterest.h"
#import "TAAllegedlyCause.h"
#import "TAStolenUsually.h"
#import "UncaughtExceptionHandler.h"
#import "FaceidViewController.h"
#import <MGFaceIDZZIDCardKit/MGFaceIDZZIDCardKit.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import <math.h>

@interface TAElegantlyCharacteristic ()
<UIScrollViewDelegate,
FSPageContentViewDelegate,
TAHomesMajorDelegate,
TAAnnouncingHelpfulDelegate,
TATheseTakesDelegate,
SSGestureLockViewDelegate,
PMainThreadWatcherDelegate,
TASuburbanTrainDelegate,
TAVulnerablePlacesDelegate>
{
    UIView * _lineView;
    UILabel * helpText;
    BOOL _canScroll;
    BOOL _neesLoadDataAgain;
    TATheseTakes *mineView;
    SSGestureLockView *gestureLockView;
    BOOL _isSendMessageToSocket;
    NSString * _currency_symbol;
}
@property (nonatomic, strong) TAPrivateMusic * homeScrollView;

@property (nonatomic, strong) UIView       * homeContentView;

@property (nonatomic, strong) TAPremisesTaking * topView;//轮播图和广告superview
@property (nonatomic, strong) TAPleasantOpportunity * bannerView;
@property (nonatomic, strong) TASmallTaking * noticeView;

@property (nonatomic, strong) TANoticesTraditional * pairsView;

@property (nonatomic, strong) UIImageView * helpImageView;

@property (nonatomic, strong) TAHomesMajor * segmentView;
@property (nonatomic, strong) FSPageContentView * pageView;

@property (nonatomic, strong) TAAnnouncingHelpful * upProgrossTableView;
@property (nonatomic, strong) TAAnnouncingHelpful * successTableView;


@end

@implementation TAElegantlyCharacteristic

- (void)viewDidLoad {

    [super viewDidLoad];
//    [UncaughtExceptionHandler setDefaultHandler];
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *dataPath = [path stringByAppendingPathComponent:@"Exception.txt"];
//    NSData *data = [NSData dataWithContentsOfFile:dataPath];
//    if (data != nil) {
////        NSLog(@"NSData类方法读取的内容是：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//        [self uploadCrashData:data];
//    }

    
    _canScroll = YES;
    _neesLoadDataAgain = NO;
    
    [self initNavcView];//初始化导航栏
 
    [SVProgressHUD show];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subViewDidScrollTop) name:@"leaveTop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidSignInSuccess) name:TAAppreciatePlansDidSignInSuccessNotifacation object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidSignOutSuccess) name:TAAppreciatePlansDidSignOutSuccessNotifacation object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkDidConnect) name:CANetworkDidConenctNotifacation object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loseNetWork) name:CANetworkDidLoseConenctNotifacation object:nil];


    [self initData];//从数据库初始化数据
    [self getData];//请求网络数据
    [TACrimeStudy openLog];
    
    kWeakSelf(self);
    [TAAmericaStudy getMarketList:^{
        [weakself freshTableView];
    }];
//    [[TAAppreciatePlans currentUser] getUserInvitationCode:^{}];
    [self freshTableView];
    
    
//    [PMainThreadWatcher sharedInstance].watchDelegate = self;
//    [[PMainThreadWatcher sharedInstance] startWatch];
    
}

-(void)uploadCrashData:(NSData*)data{
    
    NSDictionary * para = @{
        @"crash_content":data
    };
    [TACrimeStudy POST:@"common/crash" parameters:para success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue]==20000) {
            //删除掉本地的内容
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *dataPath = [path stringByAppendingPathComponent:@"Exception.txt"];
            [[NSFileManager defaultManager] removeItemAtPath:dataPath error:nil];
        }
    } failure:^(NSError *error) {
        
    }];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[TAVulnerablePlaces shareSocket] addDelegate:self];
    [self sendDataToSocket];
    [[TAAppreciatePlans currentUser] getUserDetails:^{
        
    }];
    if (helpText) {
        helpText.text = CALanguages(@"OAO证券交易平台");
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[TAVulnerablePlaces shareSocket] removeDelegate:self];
    [[TAVulnerablePlaces shareSocket] unsubCurrentReq];
    
}


#pragma mark TAVulnerablePlacesDelegate
- (void)webSocketDidOpen{
    _isSendMessageToSocket = YES;
    [self sendDataToSocket];
}

#pragma mark market_list_app 频道拼接
-(NSDictionary*)getMarketList{
    NSDictionary * dic = @{
        @"channel" : @"market_list_app",
        @"lang":LocalLanguage
    };
    return [TAVulnerablePlaces getSub:dic];
}


-(void)sendDataToSocket{
    
    [[TAVulnerablePlaces shareSocket] sendDataToSever:[self getMarketList]];
}

-(void)freshTableView{
    
    self.pairsView.dataArray = [TAAmericaStudy getHomeSymbols];
    self.upProgrossTableView.dataArray = [TAAmericaStudy getSymbolsSortByPriceChangeRatio];
    self.successTableView.dataArray = [TAAmericaStudy getSymbolsSortByPrice];
    
}

-(void)webSocket:(TAVulnerablePlaces *)webSocket didReceiveMessage:(NSDictionary *)message{
   
    if (message[@"channel"]) {
        
       if ([message[@"channel"] isEqualToString:[self getMarketList][@"subscribe"]]){
           [TAAmericaStudy getModels:message[@"content"][@"markets"]];
           
           [self freshTableView];
           NSArray * market_sort = message[@"content"][@"market_sort"];
           if (market_sort.count) {
               [CommonMethod writeToUserDefaults:market_sort withKey:CAMaretSortKey];
           }
        }
    }
}

- (void)onMainThreadSlowStackDetected:(NSArray*)slowStack {
    
    NSLog(@"current thread: %@\n", [NSThread currentThread]);
    
    NSLog(@"===begin printing slow stack===\n");
    for (NSString* call in slowStack) {
        NSLog(@"%@\n", call);
    }
    NSLog(@"===end printing slow stack===\n");
}


-(void)userDidSignInSuccess{
    
    if (mineView) {
        [mineView hide:NO];
    }
    
    [self getData];
}

-(void)userDidSignOutSuccess{
    if (mineView) {
        [mineView hide:NO];
    }
    
    [self getData];
}

-(void)netWorkDidConnect{
    NSLog(@"首页也链接上了%s",__func__);
    if (self->_neesLoadDataAgain) {
        [SVProgressHUD show];
        [self getData];
    }
    [[TAVulnerablePlaces shareSocket] reConnectServer];
}
-(void)loseNetWork{
    NSLog(@"%s",__func__);
    self->_neesLoadDataAgain = YES;
    [[TAVulnerablePlaces shareSocket] closeConnect];
}


-(void)initData{
    
    if ([TAUncommonTowels getModels:nil].count||[TABuiltDream getModels:nil].count) {
        self.bannerView.items = [TAUncommonTowels getModels:nil];
        self.noticeView.roleArray = [TABuiltDream getModels:nil];
        [self.noticeView beginRolling];
    }else{
        self.homeContentView.hidden = YES;
    }
}

-(void)languageDidChange{
   
    [[TAVulnerablePlaces shareSocket] unsubCurrentReq];
    [self sendDataToSocket];
    [self getData];
    [TAAmericaStudy getMarketList:^{
        
    }];
    [TAAmericaStudy getAllFavouriteMarkets:^{
        
    }];
}


-(void)getData{

    
//    CFAbsoluteTime AppStartLaunchTime = CFAbsoluteTimeGetCurrent();
    [TACrimeStudy GET:CAAPI_HOMEAPI parameters:nil success:^(id responseObject) {
//        NSLog(@"首页请求接口时间--%f",(CFAbsoluteTimeGetCurrent()-AppStartLaunchTime));
        self->_neesLoadDataAgain = NO;
        [SVProgressHUD dismiss];
        //刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString * contact_us_url = responseObject[@"contact_us_url"];
            NSString * about_us_url = responseObject[@"about_us_url"];
            if (contact_us_url.length) {
                [CommonMethod writeToUserDefaults:contact_us_url withKey:CONTACT_US_URL];
            }
            if (about_us_url.length) {
                [CommonMethod writeToUserDefaults:about_us_url withKey:ABOUT_US_URL];
            }
            
            
            NSString * default_market = responseObject[@"default_market"];
            if (default_market.length) {
               
                NSString * localDefault = [CommonMethod readFromUserDefaults:CAMaretDefaultMarketId];
                if (!localDefault.length) {
                    [CommonMethod writeToUserDefaults:default_market withKey:CAMaretDefaultMarketId];
                }
            }
            
            self->_currency_symbol = NSStringFormat(@"%@",responseObject[@"currency_symbol"]);
            self.segmentView.symbol = self->_currency_symbol;
            
            [self.homeScrollView ly_hideEmptyView];
            [self.pageView ly_hideEmptyView];
            
            self.bannerView.items = [TAUncommonTowels getModels:responseObject[@"sliders"]];
            self.noticeView.roleArray = [TABuiltDream getModels:responseObject[@"announcements"]];// 公告
            [self.noticeView beginRolling];
            
            [TAStrongAsking saveModels:responseObject[@"otc_currencies"] byKey:@"otc_currencies"];
            [TAStrongAsking saveModels:responseObject[@"all_currencies"] byKey:@"all_currencies"];
            self.homeContentView.hidden = NO;
            self.navcBar.lineView.hidden = YES;
            
            [self.view layoutIfNeeded];
        });
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            self->_neesLoadDataAgain = YES;
            if (!(self.bannerView.items.count||self.noticeView.roleArray.count)) {
                [self.homeScrollView ly_showEmptyView];
               
            }else{
                [self.pageView ly_showEmptyView];
            }
            [self.view layoutIfNeeded];
        });
    }];
}

-(void)viewDidLayoutSubviews{
    
    if (!self.helpImageView.isHidden) {
        [self.helpImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.homeContentView).offset(15);
            make.right.equalTo(self.homeContentView).offset(-15);
            make.top.equalTo(self.pairsView.mas_bottom).offset(15);
            make.height.equalTo(@50);
        }];
    }
    
    [self.pageView mas_remakeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.segmentView.mas_bottom);
       make.left.right.equalTo(self.homeContentView);
       make.height.mas_equalTo(MainHeight-kTopHeight-kTabBarHeight-70).priority(999);
    }];

    [self.homeContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.pageView.mas_bottom);
        make.edges.equalTo(self.homeScrollView);
        make.width.equalTo(self.homeScrollView);
    }];
}

-(void)judgeIsLogin{
    
    TAAlongDuring * login = [[TAAlongDuring alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}

#pragma mark 我的传值 指定跳转的controller
-(void)cellDidSelected:(UIViewController *)controller{
    
    if (([controller isKindOfClass:NSClassFromString(@"TADoingCombating")]||[controller isKindOfClass:NSClassFromString(@"FaceidViewController")])&&[TAAppreciatePlans currentUser].is_identified_success) {
        TAStolenUsually * person = [TAStolenUsually new];
        [self.navigationController pushViewController:person animated:YES];
    }else{
        [self.navigationController pushViewController:controller animated:YES];
    }
}

-(void)gotoLoginController{
    [self judgeIsLogin];
}


#pragma mark 初始化导航栏
-(void)initNavcView{
    
    
    UIImageView * leftImageView = [UIImageView new];
    [self.navcBar.navcContentView addSubview:leftImageView];
    leftImageView.image = IMAGE_NAMED(@"show_mine");
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navcBar.navcContentView).offset(15);
        make.centerY.equalTo(self.navcBar.navcContentView);
        make.width.height.equalTo(@32);
    }];
    leftImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMineViewController)];
    [leftImageView addGestureRecognizer:tap];
    
    
    UIImageView * logoImageView = [UIImageView new];
    [self.navcBar.navcContentView addSubview:logoImageView];
    logoImageView.image = IMAGE_NAMED(@"navc_logo");
    logoImageView.dk_imagePicker = DKImagePickerWithNames(@"navc_logo_light",@"navc_logo_dark");
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.navcBar.navcContentView);
        make.height.equalTo(@20);
    }];
    self.navcBar.lineView.hidden = NO;
    
}



#pragma mark 展示我的页面
-(void)showMineViewController{
    
    mineView = [[TATheseTakes alloc] initWithFrame:CGRectMake(0, 0, MainWidth*0.85, MainHeight)];
    mineView.delegata = self;
    mineView.delegate = self;
    [mineView showInView:self.tabBarController.view isAnimation:YES direaction:CABaseAnimationDirectionFromLeft];
}

-(void)thisViewDidDisAppear:(BOOL)animated{
    mineView = nil;
}



#pragma mark 懒加载
-(TAPremisesTaking *)topView{
    if (!_topView) {
        _topView = [TAPremisesTaking new];
        [self.homeContentView addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.homeContentView).offset(15);
            make.right.equalTo(self.homeContentView).offset(-15);
            make.top.equalTo(self.homeContentView).offset(10);
        }];
    }
    return _topView;
}
-(TAPleasantOpportunity *)bannerView{
    if (!_bannerView) {
        _bannerView = [[TAPleasantOpportunity alloc] initWithFrame:CGRectMake(0, 0, MainWidth-30, 182/383.f*(MainWidth-30))];
        [self.topView.contentView addSubview:_bannerView];
    }
    return _bannerView;
}
-(TASmallTaking *)noticeView{
    if (!_noticeView) {
        _noticeView = [TASmallTaking new];
        [self.topView.contentView addSubview:_noticeView];
        [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.topView.contentView);
            make.height.mas_offset(42);
            make.top.equalTo(self.bannerView.mas_bottom);
        }];
        
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_noticeView.mas_bottom);
        }];
    }
    return _noticeView;
}
-(TANoticesTraditional *)pairsView{
    if (!_pairsView) {
        _pairsView = [TANoticesTraditional new];
        [self.homeContentView addSubview:_pairsView];
        [_pairsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.homeContentView);
            make.top.equalTo(self.topView.mas_bottom).offset(15);
        }];
    }
    return _pairsView;
}
-(UIImageView *)helpImageView{
    if (!_helpImageView) {
        _helpImageView = [UIImageView new];
        [self.homeContentView addSubview:_helpImageView];
        _helpImageView.image = IMAGE_NAMED(@"help");
        _helpImageView.contentMode = UIViewContentModeScaleAspectFit;
        _helpImageView.userInteractionEnabled = YES;
        [_helpImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToHelperWebView)]];
        
        helpText = [UILabel new];
        [_helpImageView addSubview:helpText];
        helpText.textAlignment = NSTextAlignmentCenter;
        helpText.font = FONT_MEDIUM_SIZE(14);
        helpText.textColor = [UIColor whiteColor];
        [helpText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_helpImageView).offset(50);
            make.right.equalTo(_helpImageView).offset(-50);
            make.centerY.equalTo(_helpImageView);
        }];
        
    }
    return _helpImageView;
}
-(TAHomesMajor *)segmentView{
    if (!_segmentView) {
        _segmentView = [TAHomesMajor new];
       [self.homeContentView addSubview:_segmentView];
       _segmentView.delegate = self;
        [_segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.homeContentView);
            make.top.equalTo(self.helpImageView.mas_bottom).offset(15);
        }];
    }
    return _segmentView;
}
-(TAAnnouncingHelpful *)upProgrossTableView{
    if (!_upProgrossTableView) {
        _upProgrossTableView = [[TAAnnouncingHelpful alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _upProgrossTableView.tableViewCellStyle = 1;
        _upProgrossTableView.showInHome = YES;
        _upProgrossTableView.delegata = self;
         [_successTableView hideEmptyView];
    }
    return _upProgrossTableView;
}
-(TAAnnouncingHelpful *)successTableView{
    if (!_successTableView) {
        _successTableView = [[TAAnnouncingHelpful alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _successTableView.tableViewCellStyle = 2;
        _successTableView.delegata = self;
        _successTableView.showInHome = YES;
        [_successTableView hideEmptyView];
        
    }
    return _successTableView;
}
-(FSPageContentView *)pageView{
    if (!_pageView) {
        _pageView = [[FSPageContentView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-kTopHeight-kTabBarHeight-70)  delegate:self];
        [self.homeContentView addSubview:_pageView];
        _pageView.childsViews = @[self.upProgrossTableView,self.successTableView];
//        _pageView.ly_emptyView = [self getEmptyView];
    }
    return _pageView;
}

-(void)freshData{
    [SVProgressHUD show];
    [self getData];
  
}

-(LYEmptyView*)getEmptyView{
    
  
    LYEmptyView * emptyView = [LYEmptyView emptyActionViewWithImage:IMAGE_NAMED(@"networknull") titleStr:CALanguages(@"无网络") detailStr:nil btnTitleStr:CALanguages(@"点击重新加载") target:self action:@selector(freshData)];
    
    emptyView.titleLabTextColor = RGB(171, 175, 204);
    emptyView.titleLabFont = FONT_REGULAR_SIZE(15);
    emptyView.actionBtnFont = FONT_REGULAR_SIZE(15);
    emptyView.actionBtnTitleColor = RGB(0, 108, 219);
    emptyView.actionBtnBorderColor = RGB(0, 108, 219);
    emptyView.actionBtnBorderWidth = 1;
    emptyView.actionBtnCornerRadius = 2;
    emptyView.imageSize = CGSizeMake(83/414.f*MainWidth, 83/414.f*MainWidth);
    emptyView.contentViewY = kTopHeight+100;
    
    return emptyView;
}

-(UIView *)homeContentView{
    if (!_homeContentView) {
        _homeContentView = [UIView new];
        [self.homeScrollView addSubview:_homeContentView];
        [self.homeContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.homeScrollView);
            make.width.equalTo(self.homeScrollView);
        }];
    }
    return _homeContentView;
}
-(TAPrivateMusic *)homeScrollView{
    if (!_homeScrollView) {
        _homeScrollView = [[TAPrivateMusic alloc] init];
        [self.view addSubview:_homeScrollView];
        _homeScrollView.bounces = NO;
        _homeScrollView.delegate = self;
        _homeScrollView.showsVerticalScrollIndicator = NO;
        [_homeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(kTopHeight);
            make.left.right.bottom.equalTo(self.view);
        }];
//        _homeScrollView.ly_emptyView = [self getEmptyView];
        
    }
    return _homeScrollView;
}



#pragma mark FSSegmentTitleViewDelegate
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.homeScrollView.scrollEnabled = YES;
    self.segmentView.curType = (CAHomeSegmentType)endIndex;
}

- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress
{
    self.homeScrollView.scrollEnabled = NO;
}



#pragma mark homeScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView==self.homeScrollView) {
        CGFloat y = self.segmentView.y;

        if (self.homeScrollView.contentOffset.y >= y) {
            self.homeScrollView.contentOffset = CGPointMake(0, y);
            if (_canScroll) {
                _canScroll = NO;
                self.successTableView.tableViewCanScroll = YES;
                self.upProgrossTableView.tableViewCanScroll = YES;
            }
        }else{
            if (!_canScroll) {//子视图没到顶部
                scrollView.contentOffset = CGPointMake(0, y);
            }
        }
    }
}

-(void)subViewDidScrollTop{
  
    _canScroll = YES;
    self.successTableView.tableViewCanScroll = NO;
    self.upProgrossTableView.tableViewCanScroll = NO;
}

#pragma mark TAHomesMajorDelegate
-(void)TAHomesMajorDidSelectedIndex:(NSInteger)index{
    if (self.pageView.childsViews.count) {
        self.pageView.contentViewCurrentIndex = index;
    }
}
#pragma mark CATableViewDelegate
-(void)tableViewDidSelectedCell{
    
    [self gotoStockController:nil];
}


-(void)didEnterBackground{
    
    if (self.noticeView.isRolling) {
        [self.noticeView endRolling];
    }
}
-(void)willEnterForeground{

    if (!self.noticeView.isRolling) {
        [self.noticeView beginRolling];
    }
    [[TAVulnerablePlaces shareSocket] reConnectServer];
    [self getData];
}


-(void)jumpToHelperWebView{
    

}

- (void)didSelectedGestureLockView:(SSGestureLockView *)gestureLockView keyNumStr:(NSString *)keyNumStr{
    
    if (![keyNumStr isEqualToString:@"123456"]) {
        gestureLockView.showErrorStatus = YES;
    }else{
        
        [gestureLockView removeFromSuperview];
    }
}

-(void)gotoStockController:(TAAmericaStudy *)model{
    
    BTStockChartViewController * chat = [[BTStockChartViewController alloc] init];
    chat.currentSymbolModel = model;
    chat.backBlock = ^(TAAmericaStudy *model, TradingType type) {
        
        TADoorsPlans * tab = [TADoorsPlans shareTabbar];
        [TADoorsPlans shareTabbar].selectedIndex = 2;
        for (TASlidingHotels * controller in tab.viewControllers) {
            if ([controller isKindOfClass:TACompanyPrograms.class]) {
                TACompanyPrograms * bb = (TACompanyPrograms*)controller;
                [bb didReciveSymbolModelFromOrtherController:model type:type];
                break;
            }
        }
    };
    [self.navigationController pushViewController:chat animated:YES];
}

#pragma mark router 处理事件
-(void)routerEventWithName:(NSString *)eventName userInfo:(id)userInfo{
#pragma mark 交易对跳转
    if ([eventName isEqualToString:@"TAPastedFamous"]) {
       
        [self gotoStockController:userInfo];
        
#pragma mark 公告跳转 轮播图跳转
    }else if ([eventName isEqualToString:@"TASmallTaking"]){
        if (userInfo) {
            TAPatiosBrightest * web = [TAPatiosBrightest new];
            web.webUrl = userInfo;
            web.appointTitle = @"公告";
            [self.navigationController pushViewController:web animated:YES];
        }
    }else if ([eventName isEqualToString:@"TAPleasantOpportunity"]){
        if (userInfo) {
            NSString * url = NSStringFormat(@"%@",userInfo);
            if ([url containsString:@"http"]) {
                TAPatiosBrightest * web = [TAPatiosBrightest new];
                web.webUrl = userInfo;
                [self.navigationController pushViewController:web animated:YES];
            }
        }
    }
}

-(void)tableViewDidSelectedCell:(TAAmericaStudy*)model{
    [self gotoStockController:model];
}

-(void)shareApp{
    
    if ([TAAppreciatePlans currentUser].isAvaliable) {
        TASteelInterest * app = [TASteelInterest new];
        app.definesPresentationContext = YES;
        app.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.navigationController presentViewController:app animated:NO completion:^{
            
        }];
    }else{
        [self judgeIsLogin];
    }
}
-(void)contactUsClick{
    
    NSString * contact_us_url = [CommonMethod readFromUserDefaults:CONTACT_US_URL];
    if (contact_us_url.length) {
        TAPatiosBrightest * web = [TAPatiosBrightest new];
        web.webUrl = contact_us_url;
        web.appointTitle = @"联系我们";
        [self.navigationController pushViewController:web animated:YES];
    }
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

