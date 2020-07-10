//
//  TASomeoneWonderful.m
//  JLGP
//
//  Created by ZEMac on 2019/9/7.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TASomeoneWonderful.h"
#import "TAAnnouncingHelpful.h"
#import "FSPageContentView.h"
#import "TALivesTogether.h"
#import "TADreamsFollow.h"
#import "TADreamSubstitute.h"
#import "TAAmericaStudy.h"
#import "TADoorsPlans.h"

@interface TASomeoneWonderful ()
<TALivesTogetherDelegate,
FSPageContentViewDelegate,
TADreamsFollowDelegate,
TADreamSubstituteDelegate,
TAAnnouncingHelpfulDelegate>
{
    TADreamSubstitute * _nameView;
    TADreamSubstitute * _newPriceView;
    TADreamSubstitute * _rangeView;
    
    TADreamSubstitute * _lastChangeNotiView;

    CGFloat  headerHeight;
    
    NSString * _coinRegion;
    NSString * _code;
    CASymbolsSortType _curType;
    
}
@property (nonatomic, strong) FSPageContentView * pageView;
@property (nonatomic, strong) TALivesTogether * segmentView;
@property (nonatomic, strong) NSMutableArray * tableViewArray;
@property (nonatomic, strong) TADreamsFollow * bitListView;
@property (nonatomic, strong) UIView * notiView;
@property (nonatomic, strong) NSArray * bitListArray;

@end

@implementation TASomeoneWonderful

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[TAVulnerablePlaces shareSocket] addDelegate:self];
    [self sendMessageToSocket];
    
    [self freshCurrentShowTableView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
     [[TAVulnerablePlaces shareSocket] removeDelegate:self];
     [[TAVulnerablePlaces shareSocket] unsubCurrentReq];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navcTitle = @"行情";
    [self initSegmentView];
    [self initBitListView];
    [self initNotiView];
    [self initPageView];
    [self initDa];
    
    kWeakSelf(self);
    [TAAmericaStudy getAllFavouriteMarkets:^{
        [weakself freshCurrentShowTableView];
    }];
}

-(void)webSocketDidOpen{
    
    [self sendMessageToSocket];
}
-(void)sendMessageToSocket{
    
    [[TAVulnerablePlaces shareSocket] sendDataToSever:[self getMarketList]];
}

-(void)webSocket:(TAVulnerablePlaces *)webSocket didReceiveMessage:(NSDictionary *)message{
    
    if (message[@"channel"]) {
        
       if ([message[@"channel"] isEqualToString:[self getMarketList][@"subscribe"]]){

           [TAAmericaStudy getModels:message[@"content"][@"markets"]];
           
           NSArray * market_sort = message[@"content"][@"market_sort"];
           if (market_sort.count) {
               [CommonMethod writeToUserDefaults:market_sort withKey:CAMaretSortKey];
           }
           //更新页面
           [self freshCurrentShowTableView];
        }
    }
}

#pragma mark market_list_app 频道拼接
-(NSDictionary*)getMarketList{
    NSDictionary * dic = @{
        @"channel" : @"market_list_app",
        @"lang":LocalLanguage
    };
    return [TAVulnerablePlaces getSub:dic];
}


-(void)tableViewDidSelectedCell:(TAAmericaStudy *)model{
    
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

-(void) TALivesTogether_didSelectedIndex:(NSInteger)index{
    

    switch (index) {
        case 0:
            _coinRegion = @"favourite";
            self.bitListArray = @[];
            
            break;
        case 1://全部
            _coinRegion = @"all";
            self.bitListArray = @[];
            
            break;
          
        default:
            break;
    }
    [self freshCurrentShowTableView];

}
-(void)initSegmentView{
    
    self.segmentView = [[TALivesTogether alloc] initWithFrame:CGRectMake(15, kTopHeight+5, MainWidth-30, 33)];
    [self.view addSubview:self.segmentView];
    
    self.segmentView.delegata = self;
}

-(void)initBitListView{
    
    self.bitListView = [[TADreamsFollow alloc] init];
    self.bitListView.delegate = self;
    [self.view addSubview:self.bitListView];
    [self.bitListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.segmentView.mas_bottom).offset(5);
    }];
    
}
-(void)initNotiView{
    
    self.notiView = [UIView new];
    [self.view addSubview:self.notiView];
    
    _nameView = [TADreamSubstitute new];
    _newPriceView = [TADreamSubstitute new];
    _rangeView = [TADreamSubstitute new];
    [self.notiView addSubview:_nameView];
    [self.notiView addSubview:_newPriceView];
    [self.notiView addSubview:_rangeView];
    _nameView.delegate = self;
    _newPriceView.delegate = self;
    _rangeView.delegate = self;
    
    NSArray * views = @[_nameView,_newPriceView,_rangeView];
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:0 tailSpacing:0];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.notiView);
        make.height.equalTo(self.notiView);
    }];
    
    _nameView.alignment = AlignmentLeft;
    _newPriceView.alignment = AlignmentCenter;
    _rangeView.alignment = AlignmentRight;
    
    _nameView.key = @"ask_unit";
    _newPriceView.key = @"last_price";
    _rangeView.key = @"price_change_ratio";
}

-(void)initDa{
    _nameView.name = @"名称";
    _newPriceView.name = @"最新价";
    _rangeView.name = @"涨跌幅";
    self.segmentView.segmentItems = @[@"自选",@"股票"];
    
    _curType = CASymbolsSortTypeNone;
    self.segmentView.segmentCurrentIndex = 0;
}

-(void)languageDidChange{
  
    self.navcTitle = @"行情";
    [self initDa];
}

-(void)initPageView{
    
    self.pageView = [[FSPageContentView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-kTopHeight-kTabBarHeight) delegate:self];
    [self.view addSubview:self.pageView];
    
}
#pragma mark TADreamsFollowDelegate
-(void)bitListViewDidSelectedIndex:(NSInteger)index{
    
    self.pageView.contentViewCurrentIndex = index;
    if (self.bitListArray.count>index) {
        _code = self.bitListArray[index];
    }
    [self freshCurrentShowTableView];
}

-(void)freshCurrentShowTableView{

    if (_coinRegion.length) {
        if (self.pageView.contentViewCurrentIndex<self.tableViewArray.count) {
            TAAnnouncingHelpful * tableView = (TAAnnouncingHelpful*)self.tableViewArray[self.pageView.contentViewCurrentIndex];
            if (tableView) {
                NSArray *data = [TAAmericaStudy screenMarketsListWithCoinRegion:_coinRegion currencyCode:_code sortKey:_lastChangeNotiView.key sortType:_curType];
                tableView.dataArray = data;
            }
        }
    }
}

#pragma mark TADreamSubstituteDelegate
-(void)notiUpDownViewDidChange:(TADreamSubstitute *)view rowState:(CASymbolsSortType)type{
    
    _curType = type;
    
    if (_lastChangeNotiView!=view) {
        _lastChangeNotiView.type = CASymbolsSortTypeNone;
    }
    _lastChangeNotiView = view;
    [self freshCurrentShowTableView];
}
#pragma mark TALivesTogetherDelegate
-(void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.bitListView.index = endIndex;
    [self freshCurrentShowTableView];
}

-(void)setBitListArray:(NSArray *)bitListArray{
    _bitListArray = bitListArray;
    
    [self.tableViewArray removeAllObjects];
    
    self.bitListView.bitListDataArray = bitListArray;
    self.bitListView.hidden = !_bitListArray.count;
    
    if (_bitListArray.count>1) {
        
        [self.bitListView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15);
            make.top.equalTo(self.segmentView.mas_bottom).offset(5);
            make.height.equalTo(@42);
        }];
        //创建底部tableviews
        for (int i=0; i<bitListArray.count; i++) {
            TAAnnouncingHelpful *tableView = [[TAAnnouncingHelpful alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            tableView.delegata = self;
            tableView.tableViewCellStyle = 1;
            tableView.showInHome = NO;
            tableView.tableViewCanScroll = YES;
            tableView.ignoreScrollDelegate = YES;
            [self.tableViewArray addObject:tableView];
        }
        
    }else{
        //创建一个
        TAAnnouncingHelpful *tableView = [[TAAnnouncingHelpful alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegata = self;
        tableView.tableViewCellStyle = 1;
        tableView.showInHome = NO;
        tableView.tableViewCanScroll = YES;
        tableView.ignoreScrollDelegate = YES;
        [self.tableViewArray addObject:tableView];
    }
    
    self.pageView.childsViews = self.tableViewArray;
    
    [self.notiView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@30);
        if (self.bitListArray.count) {
            make.top.equalTo(self.bitListView.mas_bottom).offset(10);
        }else{
            make.top.equalTo(self.segmentView.mas_bottom).offset(10);
        }
    }];
    
    [self.pageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.notiView.mas_bottom);
    }];
    
    if (!self.bitListView.isHidden) {
        self.bitListView.index = 0;
    }
}

-(NSMutableArray *)tableViewArray{
    if (!_tableViewArray) {
        _tableViewArray = @[].mutableCopy;
    }
    return _tableViewArray;
}

@end
