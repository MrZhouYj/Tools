//
//  CAMoneyViewController.m
//  JLGP
//
//   9/25.
//  Copyright © 2019 CA. All rights reserved.
//

#import "CAMoneyViewController.h"
#import "CAMoneyTableViewHeaderView.h"
#import "CAMoneyTableViewCell.h"
#import "CACurrencyMoneyModel.h"
#import "CAAssetDetailsViewController.h"
#import "CAAccountTotalView.h"
#import "CATransferViewController.h"

@interface CAMoneyViewController ()
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

@property (nonatomic, strong) CAMoneyTableViewHeaderView * headView;

@property (nonatomic, strong) CAAccountTotalView *totalView;

@end

@implementation CAMoneyViewController

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
    
    
    [CANetworkHelper GET:CAAPI_MINE_ALL_ASSET parameters:nil success:^(id responseObject) {
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
        self.currentAccount = [[[CAAccounts shareAccouts] getAccounts] firstObject];
    }
    self.totalView.accountType = self.currentAccount[@"type"];
    self.count++;
    
    NSDictionary * para = @{
        @"account_type": self.currentAccount[@"type"]
    };
    
    [CANetworkHelper GET:CAAPI_MINE_ASSET parameters:para success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] integerValue]==20000) {
            
            NSDictionary * data = responseObject[@"data"];
            NSArray * list = data[@"list"];
            
            self.dataArray = [CACurrencyMoneyModel getModels:list];
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
    
    CAMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CAMoneyTableViewCell"];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row<self.dataArray.count) {
        CATransferViewController * asset = [CATransferViewController new];
        CACurrencyMoneyModel * model = self.dataArray[indexPath.row];
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
        [_tableView registerClass:[CAMoneyTableViewCell class] forCellReuseIdentifier:@"CAMoneyTableViewCell"];
        
        _tableView.tableHeaderView = self.totalView;
        
    }
    return _tableView;
}

-(CAAccountTotalView *)totalView{
    if (!_totalView) {
        _totalView = [[CAAccountTotalView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 100)];
    }
    return _totalView;
}

-(CAMoneyTableViewHeaderView *)headView{
    if (!_headView) {
        _headView = [CAMoneyTableViewHeaderView new];
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
        CATransferViewController * trans = [CATransferViewController new];
        [self.navigationController pushViewController:trans animated:YES];
    }
}

@end
