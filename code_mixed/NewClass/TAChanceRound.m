//
//  TAChanceRound.m
//  JLGP
//
//   10/10.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAChanceRound.h"
#import "TAShowingIndeed.h"
#import "TALivesTogether.h"
#import "TAPeopleAbove.h"
#import "TABecauseContinuously.h"
#import "TAStrongAsking.h"
#import "TATrialsRelief.h"
#import "TASorrowPress.h"
#import "TAHappiestAdvisor.h"
#import "TAWhereScenic.h"
#import "TAGuardIsland.h"
@interface TAChanceRound ()
<UITableViewDelegate,
UITableViewDataSource,
TALivesTogetherDelegate,
TAShowingIndeedDelegata
>
{
    BOOL _isDidAppear;
}
@property (nonatomic, strong) NSMutableArray * dataSourceArray;
@property (nonatomic, strong) TAGuardIsland * tableView;
@property (nonatomic, strong) TAShowingIndeed * rowView;
@property (nonatomic, strong) TALivesTogether * segmentView;

@property (nonatomic, copy) NSString * sellTitle;
@property (nonatomic, copy) NSString * buyTitle;

@property (nonatomic, copy) NSString * trade_type;

@property (nonatomic, strong) NSArray * currencies;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) NSInteger allPage;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL isNoMoreData;


@end

@implementation TAChanceRound

-(NSArray *)currencies{
    if (!_currencies) {
        _currencies = [TAStrongAsking getModelsByKey:@"otc_currencies"];
    }
    return _currencies;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentPage = 1;
    
    if (self.type==1) {
        self.navcTitle = @"我的广告";
    }else if (self.type==2){
        self.navcTitle = @"我的订单";
    }
    
    self.trade_type = @"sell";
    
    [self initTopView];
    [SVProgressHUD show];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.segmentView&&self.segmentView.segmentItems.count) {
        self.segmentView.segmentCurrentIndex = self.currentIndex;
    }
}

-(void)TALivesTogether_didSelectedIndex:(NSInteger)index{
    self.currentIndex = index;
    [self resetPage];
    [self getData];
}

-(void)getData{
    
    NSString * url = CAAPI_OTC_MY_ADVERTISEMENTS;
    if (self.type==2) {
        url = CAAPI_OTC_MY_ORDERS;
    }
    
    TAStrongAsking * model = self.currencies[self.currentIndex];
    if (!model.code) {
        return;
    }
    NSMutableDictionary*para = @{}.mutableCopy;
    if (self.type==2) {
        [para setValue:@(self.currentPage) forKey:@"current_page"];
    }
    [para setValue:NSStringFormat(@"%@",model.code) forKey:@"code"];
    [para setValue:NSStringFormat(@"%@",self.trade_type) forKey:@"trade_type"];
    
    [TACrimeStudy GET:url parameters:para success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            if (self.type==1) {
                [self.dataSourceArray removeAllObjects];
                [self.dataSourceArray addObjectsFromArray:[TASorrowPress getModels:responseObject[@"data"]]];
            }else if (self.type==2){
                
                self.currentPage = [responseObject[@"current_page"] integerValue];
                self.allPage = [responseObject[@"total_page"] integerValue];
                if (self.currentPage>=self.allPage) {
                    self.isNoMoreData = YES;
                    [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
                }else{
                    self.isNoMoreData = NO;
                    [self.tableView.mj_footer setState:MJRefreshStateIdle];
                }
                
                if (self.currentPage==1) {
                    [self.dataSourceArray removeAllObjects];
                }
                
                [self.dataSourceArray addObjectsFromArray:[TATrialsRelief getModels:responseObject[@"data"]]];
            }
            
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
             });
        });
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
    }];
    
}

-(void)initTopView{
    
    UIView * topView = [UIView new];
    [self.view addSubview:topView];
    topView.dk_backgroundColorPicker = DKColorPickerWithKey(WhiteItemBackGroundColor);
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navcBar.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    
    self.rowView = [TAShowingIndeed new];
    [topView addSubview:self.rowView];
    self.rowView.title = self.sellTitle;
    self.rowView.titleFont = FONT_REGULAR_SIZE(17);
    self.rowView.titleColor = HexRGB(0x191d26);
    self.rowView.imageTineColor = HexRGB(0x191d26);
    self.rowView.up = YES;
    self.rowView.delegata = self;
    self.rowView.layOut = TAShowingIndeedLayoutBetween;
    
    [self.rowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(15);
        make.top.bottom.equalTo(topView);
        make.width.equalTo(@200);
    }];
    
    if (self.type==1) {
        //添加+
        UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [topView addSubview:addButton];
        
        [addButton setImage:[IMAGE_NAMED(@"order_add") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [addButton setTintColor:HexRGB(0x000000)];
        [addButton setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
        [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topView).offset(-15);
            make.centerY.equalTo(topView);
            make.width.height.equalTo(@20);
        }];
        
        [addButton addTarget:self action:@selector(addAvClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    self.segmentView = [[TALivesTogether alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 40)];
    [self.view addSubview:self.segmentView];
    self.segmentView.delegata = self;
    self.segmentView.isFixedSpace = NO;
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.rowView.mas_bottom);
        make.height.equalTo(@40);
    }];
    self.segmentView.segmentItems = [TAStrongAsking getCodeBigArray:self.currencies];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.segmentView.mas_bottom);
    }];
    
   
//    self.tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[TAPeopleAbove class] cellHeight:195];
//    self.tableView.tabAnimated.superAnimationType = TABViewSuperAnimationTypeShimmer;
//    self.tableView.tabAnimated.adjustBlock = ^(TABComponentManager * manager){
//        manager.animation(10).remove();
//    };
}

-(void)addAvClick{
    
    TABecauseContinuously * ad = [TABecauseContinuously new];
    [self.navigationController pushViewController:ad animated:YES];
}

-(void)TAShowingIndeed_didChangeRowState:(int)state rowView:(nonnull TAShowingIndeed *)rowView{
    
    CAMenuAction * action1 = [CAMenuAction actionWithTitle:self.sellTitle image:nil handler:^(CAMenuAction *action) {
        self.rowView.title = self.sellTitle;
        self.rowView.up = !self.rowView.up;
        self.trade_type = @"sell";
        [SVProgressHUD show];
        [self resetPage];
        [self getData];
    }];
    CAMenuAction * action2 = [CAMenuAction actionWithTitle:self.buyTitle image:nil handler:^(CAMenuAction *action) {
        self.rowView.title = self.buyTitle;
        self.rowView.up = !self.rowView.up;
        self.trade_type = @"buy";
        [SVProgressHUD show];
        [self resetPage];
        [self getData];
    }];
    
    TACountryShare * menuView = [TACountryShare menuWithActions:@[action1,action2] width:150 relyonView:self.rowView];
    
    [menuView show];
}


#pragma mark tableView代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type==1) {
        return [TAHappiestAdvisor getCellHeight];
    }else if (self.type==2){
        return [TAPeopleAbove getCellHeight];
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type==1) {
        TAHappiestAdvisor * cell = [tableView dequeueReusableCellWithIdentifier:@"TAHappiestAdvisor"];
        cell.action_type = @"MyAdvertisementList";
        cell.model = self.dataSourceArray[indexPath.row];
        
        return cell;
    }else{
        TAPeopleAbove * cell = [tableView dequeueReusableCellWithIdentifier:@"TAPeopleAbove"];
         cell.model = self.dataSourceArray[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type==1) {
        TABecauseContinuously * adViewController = [TABecauseContinuously new];
        adViewController.model = [self.dataSourceArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:adViewController animated:YES];
    }else if (self.type==2){
        
        TAWhereScenic * order = [TAWhereScenic new];
        TATrialsRelief * model = self.dataSourceArray[indexPath.row];
        order.advertisement_id = model.ID;
        [self.navigationController pushViewController:order animated:YES];
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[TAGuardIsland alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        kWeakSelf(self);
        [_tableView addReFreshHeader:^{
            [weakself resetPage];
            [weakself getData];
        }];
        if (self.type==2) {
            [_tableView addReFreshFooter:^{
                
            }];
        }
        [_tableView registerClass:[TAPeopleAbove class] forCellReuseIdentifier:@"TAPeopleAbove"];
        [_tableView registerClass:[TAHappiestAdvisor class] forCellReuseIdentifier:@"TAHappiestAdvisor"];
    }
    return _tableView;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row==self.dataSourceArray.count-2&&!self.isNoMoreData&&self.type==2) {
        
        self.currentPage++;
        [self getData];
    }
}
-(void)resetPage{
    self.currentPage = 1;
    
}

-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = @[].mutableCopy;
    }
    return _dataSourceArray;
}

-(NSString *)buyTitle{
    if (self.type==1) {
        return CALanguages(@"买入广告");
    }else if (self.type==2){
        return CALanguages(@"买入订单");
    }else{
        return @"";
    }
}
-(NSString *)sellTitle{
    if (self.type==1) {
        return CALanguages(@"出售广告") ;
    }else if (self.type==2){
        return CALanguages(@"出售订单");
    }else{
        return @"";
    }
}


@end
