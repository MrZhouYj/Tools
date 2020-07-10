//
//  TAThinkWorry.m
//  JLGP
//
//   9/27.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAThinkWorry.h"
#import "TAEnoughWiden.h"
#import "TAProbablyAccess.h"
#import "TAGuardIsland.h"

@interface TAThinkWorry ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) TAGuardIsland *tableView;

@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation TAThinkWorry

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.navcTitle = @"我的好友";

    [self getData];
}

-(void)getData{

    
    [TACrimeStudy GET:CAAPI_MINE_FRIENDS parameters:nil success:^(id responseObject) {
       
        if ([responseObject[@"code"] integerValue]==20000) {
            self.dataArray = [TAProbablyAccess getModels:responseObject[@"data"][@"my_friends"]];
            dispatch_async(dispatch_get_main_queue(), ^{

                [self.tableView reloadData];
            });
        }else{
        
            Toast(responseObject[@"messasge"]);
        }
        
    } failure:^(NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TAEnoughWiden * cell = [tableView dequeueReusableCellWithIdentifier:@"TAEnoughWiden"];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[TAGuardIsland alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(kTopHeight, 0, 0, 0));
        }];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:NSClassFromString(@"TAEnoughWiden") forCellReuseIdentifier:@"TAEnoughWiden"];
        
    }
    return _tableView;
}

@end
