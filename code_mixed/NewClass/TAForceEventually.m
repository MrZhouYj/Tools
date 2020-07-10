//
//  TAForceEventually.m
//  JLGP
//
//   10/21.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAForceEventually.h"
#import "FSPageContentView.h"
#import "TAPointedWonderful.h"
#import "TACompaniesEveryone.h"
#import "TAUsualMessages.h"
#import "TASurveillanceMatter.h"
#import "TASymbolRemains.h"

@interface TAForceEventually ()
<FSPageContentViewDelegate,
TAPointedWonderfulDelegate
>
{
    BOOL _isHistory;
    NSInteger _currentIndex;
    BOOL _isLoading;
}
@property (nonatomic, strong) TAPointedWonderful * chooseView;

@property (nonatomic, strong) FSPageContentView * pageView;

@property (nonatomic, strong) TAUsualMessages * filterView;

@end

@implementation TAForceEventually

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
    [SVProgressHUD show];
    [self getData];
}

-(void)getData{
    
    
    NSString * requestUrl  = CAAPI_CRYPTO_TO_CRYPTO_ORDERS;
    if (_isHistory) {
        requestUrl = CAAPI_CRYPTO_TO_CRYPTO_MY_ORDERS;
    }
    
    __block TACompaniesEveryone * tableView = self.pageView.childsViews[_currentIndex];
    
    NSDictionary * para = @{
        @"current_page":NSStringFormat(@"%zd",tableView.current_page),
        @"market_id":NSStringFormat(@"%@",self.market_id)
    };
    NSLog(@"para====%@",para);
    tableView.isLoadingData = YES;

    [TACrimeStudy GET:requestUrl parameters:para success:^(id responseObject) {
        [SVProgressHUD dismiss];
        tableView.isLoadingData = NO;
        [tableView endFresh];
        if ([responseObject[@"code"] integerValue]==20000) {
            tableView.current_page = [responseObject[@"current_page"] integerValue];
            tableView.total_page = [responseObject[@"total_page"] integerValue];
            if (tableView.current_page>=tableView.total_page) {
                [tableView noMoreData];
            }else{
                [tableView setStateToIdle];
            }
            NSArray * data = responseObject[@"data"];
            if (data) {
                if (tableView.current_page==1) {
                   [tableView.datas removeAllObjects];
                }
                if (data.count) {
                    NSArray * models = [TASymbolRemains getModels:data];
                    [tableView.datas addObjectsFromArray:models];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableView reloadData];
                });
            }
        }

    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        tableView.isLoadingData = NO;
        [tableView endFresh];
    }];
}

-(void)routerEventWithName:(NSString *)eventName userInfo:(id)userInfo{
    if ([eventName isEqualToString:@"loadNextPageData"]){
        //加载下一页的数据
        [self getData];
    }else if ([eventName isEqualToString:@"freshData"]){
        //刷新数据
        [self getData];
    }else if ([eventName isEqualToString:@"pushToEntrustListInfoController"]) {
        
        TASymbolRemains * model = (TASymbolRemains*)userInfo;
        
        if (model.ID) {
            TASurveillanceMatter * listInfo = [TASurveillanceMatter new];
            listInfo.trade_id = model.ID;
            [self.navigationController pushViewController:listInfo animated:YES];
        }
        
    }else if([eventName isEqualToString:@"cancleEntrust"]){
        if (!_isLoading) {
            TASymbolRemains * model = (TASymbolRemains*)userInfo;
            [self cancleEntrust:model];
            _isLoading = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self->_isLoading = NO;
            });
        }
    }
}

-(void)cancleEntrust:(TASymbolRemains *)model{
    
    NSDictionary * para = @{
        @"id":NSStringFormat(@"%@",model.ID),
        
    };
    [SVProgressHUD show];
    [TACrimeStudy MATCHERPOST:[NSString stringWithFormat:@"%@%@",self.market_id,CAAPI_CRYPTO_TO_CRYPTO_CANCEL_ORDERS] parameters:para success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] integerValue]==20000) {
            dispatch_async(dispatch_get_main_queue(), ^{
                TACompaniesEveryone * tableView = self.pageView.childsViews[self.pageView.contentViewCurrentIndex];
                tableView.current_page = 1;
                [self getData];
            });
        }
        Toast(responseObject[@"message"]);
        self->_isLoading = NO;
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        self->_isLoading = NO;
    }];
    
}

-(void)showFilterCkick{
    
    if (self.filterView.isShowing) {
        [self.filterView hide:YES];
    }else{
        [self.filterView showInView:self.view isAnimation:YES direaction:CABaseAnimationDirectionFromTop];
        [self.view bringSubviewToFront:self.navcBar];
        self.filterView.isHistory = self.chooseView.currentIndex;
        [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(kTopHeight);
        }];
    }
    
}

-(void)initSubViews{
    
    self.chooseView = [TAPointedWonderful new];
    [self.view addSubview:self.chooseView];
    self.chooseView.delegata = self;
    [self.chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navcBar.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    self.pageView = [[FSPageContentView alloc] initWithFrame:CGRectMake(0, kTopHeight+40, MainWidth, MainHeight-kTopHeight-40) delegate:self];
    [self.view addSubview:self.pageView];
    self.pageView.delegate = self;
    NSMutableArray * tableViews = @[].mutableCopy;
    for (int i=0; i<2; i++) {
        TACompaniesEveryone * tableView = [[TACompaniesEveryone alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        if (i==1) {
            tableView.isHistory = YES;
        }
        tableView.tag = 1000+i;
        [tableViews addObject:tableView];
    }
    self.pageView.childsViews = tableViews;
    
}


-(void)TAPointedWonderful_didSelectIndex:(NSInteger)index{
    
    
    self.pageView.contentViewCurrentIndex = index;
    _currentIndex = index;
    _isHistory = index;
    TACompaniesEveryone * tableView = self.pageView.childsViews[_currentIndex];
    if (!tableView.datas.count) {
        [self getData];
    }
}

-(void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    
    self.chooseView.currentIndex = endIndex;
    _currentIndex = endIndex;
    
}

-(TAUsualMessages *)filterView{
    if (!_filterView) {
        _filterView = [[TAUsualMessages alloc] initWithFrame:CGRectMake(0, kTopHeight, MainWidth, 200)];
    }
    return _filterView;
}
-(void)initNavcRightView{
    
//    UIButton * filtButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.navcBar addSubview:filtButton];
//
//    [filtButton setImage:IMAGE_NAMED(@"filter") forState:UIControlStateNormal];
//
//    [filtButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.navcBar).offset(-20);
//        make.centerY.equalTo(self.navcBar.backButton);
//        make.width.height.equalTo(@24);
//    }];
//
//    [filtButton setEnlargeEdgeWithTop:5 right:20 bottom:5 left:20];
//    [filtButton addTarget:self action:@selector(showFilterCkick) forControlEvents:UIControlEventTouchUpInside];
}

@end
