//
//  TAWanderShopping.m
//  JLGP
//
//  Created by  on 2019/12/23.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAWanderShopping.h"
#import "TARemainsDream.h"

@interface TAWanderShopping ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSDictionary * data;

@end

@implementation TAWanderShopping

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
}

-(void)getData{
    
    NSDictionary * para = @{
        @"record_type":NSStringFormat(@"%@",self.dataDic[@"record_type"]),
        @"record_id":NSStringFormat(@"%@",self.dataDic[@"record_id"]),
    };
    
    [TACrimeStudy GET:CAAPI_MINE_ASSETS_RECORDS_DETAIL parameters:para success:^(id responseObject) {
        
        if ([responseObject[@"code"] integerValue]==20000) {
            NSDictionary * data = responseObject[@"data"];
            self.navcTitle = NSStringFormat(@"%@",data[@"title"]);
            self.data = data[@"detail"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.allKeys.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TARemainsDream * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TARemainsDream class])];
    if (indexPath.row < self.data.allKeys.count) {
        cell.data  = [self.data objectForKey:self.data.allKeys[indexPath.row]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
//        _tableView.backgroundColor = HexRGB(0xf6f6fa);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[TARemainsDream class] forCellReuseIdentifier:NSStringFromClass([TARemainsDream class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.navcBar.mas_bottom).offset(0);
        }];
    }
    return _tableView;
}

@end
