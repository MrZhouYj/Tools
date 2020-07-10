//
//  TATakenTibet.m
//  JLGP
//
//   9/25.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TATakenTibet.h"
#import "TAAllowsStarted.h"
#import "TAKnowsTraditional.h"
#import "TAAccessNation.h"
#import "TAMediumStreet.h"
#import "TAThreatenedSuccessful.h"
#import "TAChancesRemarks.h"

@interface TATakenTibet ()
<UITableViewDelegate,
UITableViewDataSource>
{
    NSString * total_account;
    NSString * stock_all_sssets;
    NSString * stock_assets;
    NSString * otc_all_sssets;
    
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSDictionary * currentAccount;
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) TAAllowsStarted * headView;

@property (nonatomic, strong) TAThreatenedSuccessful *totalView;

@end

@implementation TATakenTibet

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navcTitle = @"我的资产";
    
    [SVProgressHUD show];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [SVProgressHUD show];
    [self getAllAssets];
    [self getAsset];
    
}

-(void)getAllAssets{
    
    
    [TACrimeStudy GET:CAAPI_MINE_ALL_ASSET parameters:nil success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] integerValue]==20000) {
            NSLog(@"%@",responseObject);
            self->total_account = responseObject[@"data"][@"total_account"];
            self->stock_all_sssets = responseObject[@"data"][@"stock_all_assets"];
            self->stock_assets = responseObject[@"data"][@"stock_assets"];
            self->otc_all_sssets = responseObject[@"data"][@"otc_all_assets"];
            self.headView.assets = self->total_account;
            self.totalView.stock_assets = self->stock_assets;
            self.totalView.stock_all_sssets = self->stock_all_sssets;
            self.totalView.otc_all_sssets = self->otc_all_sssets;
            self.count++;
        }else{
            Toast(responseObject[@"message"]);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

-(void)setCount:(NSInteger)count{
    _count = count;
    NSLog(@"%ld",(long)_count);
    if (_count>1) {
        [self.totalView updateUI];
    }
}

-(void)getAsset{
    
    if (!self.currentAccount) {
        self.currentAccount = [[[TACarryWhich shareAccouts] getAccounts] firstObject];
    }
    self.totalView.accountType = self.currentAccount[@"type"];
    self.count++;
    
    NSDictionary * para = @{
        @"account_type": self.currentAccount[@"type"]
    };
    
    [TACrimeStudy GET:CAAPI_MINE_ASSET parameters:para success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] integerValue]==20000) {
            
            NSDictionary * data = responseObject[@"data"];
            NSArray * list = data[@"list"];
            
            self.dataArray = [TAAccessNation getModels:list];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
            });
        }else{
            Toast(responseObject[@"message"]);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TAKnowsTraditional *cell = [tableView dequeueReusableCellWithIdentifier:@"TAKnowsTraditional"];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row<self.dataArray.count) {
        TAChancesRemarks * asset = [TAChancesRemarks new];
        TAAccessNation * model = self.dataArray[indexPath.row];
        asset.code = model.code;
        asset.accountType = self.currentAccount[@"type"];
        [self.navigationController pushViewController:asset animated:YES];
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.headView.mas_bottom);
        }];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TAKnowsTraditional class] forCellReuseIdentifier:@"TAKnowsTraditional"];
        
        _tableView.tableHeaderView = self.totalView;
        
    }
    return _tableView;
}

-(TAThreatenedSuccessful *)totalView{
    if (!_totalView) {
        _totalView = [[TAThreatenedSuccessful alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 100)];
    }
    return _totalView;
}

-(TAAllowsStarted *)headView{
    if (!_headView) {
        _headView = [TAAllowsStarted new];
        [self.view addSubview:_headView];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.navcBar.mas_bottom);
        }];
    }
    return _headView;
}

-(void)routerEventWithName:(NSString *)eventName userInfo:(id)userInfo{
    if ([eventName isEqualToString:@"pushViewController"]) {
        UIViewController * contro = [[NSClassFromString(userInfo) alloc] init];
        [self.navigationController pushViewController:contro animated:YES];
    }else if ([eventName isEqualToString:@"changeAccountType"]){
        self.currentAccount = userInfo;
        [self getAsset];
    }else if ([eventName isEqualToString:@"transferAction"]){
        TAChancesRemarks * trans = [TAChancesRemarks new];
        [self.navigationController pushViewController:trans animated:YES];
    }
}

@end
