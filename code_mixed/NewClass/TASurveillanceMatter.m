//
//  TASurveillanceMatter.m
//  JLGP
//
//  Created by  on 2019/12/25.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TASurveillanceMatter.h"
#import "TAAttachedShoes.h"
#import "TAPlaceYoung.h"
#import "TASymbolRemains.h"

@interface TASurveillanceMatter ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray * datas;

@property (nonatomic, strong) TASymbolRemains * model;

@end

@implementation TASurveillanceMatter

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bigNavcTitle = @"成交明细";
    
    [self initTableView];
    
    [self getData];
}

-(void)getData{
    
    [SVProgressHUD show];
    NSDictionary * para = @{
        @"trade_id":NSStringFormat(@"%@",self.trade_id)
    };
    
    [TACrimeStudy GET:CAAPI_CRYPTO_TO_CRYPTO_TRADE_DEATAIL parameters:para success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] integerValue]==20000) {
            
            self.datas = responseObject[@"data"][@"list_view"];
            self.model = [TASymbolRemains new];
            [self.model dealData:responseObject[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }

    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 180;
    }
     return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = HexRGB(0xf6f6f6);
    view.frame = CGRectMake(0, 0, MainWidth, 0);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section==0) {
        TAAttachedShoes * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TAAttachedShoes class])];
        if (self.model) {
            cell.model = self.model;
        }
        
        cell.hideRightRow = YES;
        return cell;
    }else{
        TAPlaceYoung * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TAPlaceYoung class])];
        if (indexPath.row<self.datas.count) {
            NSDictionary * dic = self.datas[indexPath.row];
            if (dic) {
                cell.leftNotiLabel.text = NSStringFormat(@"%@",dic[@"key"]);
                cell.rightContentLabel.text = NSStringFormat(@"%@",[dic[@"value"] uppercaseString]);
            }
        }
        
        return cell;
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


-(void)initTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[TAAttachedShoes class] forCellReuseIdentifier:NSStringFromClass([TAAttachedShoes class])];
    [self.tableView registerClass:[TAPlaceYoung class] forCellReuseIdentifier:NSStringFromClass([TAPlaceYoung class])];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.bigTitleLabel.mas_bottom);
    }];
}

@end
