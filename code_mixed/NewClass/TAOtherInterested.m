//
//  TAOtherInterested.m
//  JLGP
//
//   10/14.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAOtherInterested.h"
#import "TAHappiestAdvisor.h"
#import "TAGuardIsland.h"

@interface TAOtherInterested()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) TAGuardIsland * tableView;

@property (nonatomic, assign) BOOL isNoMoreData;


@end

@implementation TAOtherInterested

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initTableView];
    }
    return self;
}


-(void)initTableView{
    
    self.tableView = [[TAGuardIsland alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.estimatedRowHeight = 0;
//    self.tableView.estimatedSectionHeaderHeight = 0;
//    self.tableView.estimatedSectionFooterHeight = 0;
    [self addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(WhiteItemBackGroundColor);
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[TAHappiestAdvisor class] forCellReuseIdentifier:@"TAHappiestAdvisor"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self);
    }];
    kWeakSelf(self);
    [self.tableView addReFreshFooter:^{
        
    }];
    [self.tableView addReFreshHeader:^{
        
        [weakself routerEventWithName:@"freshData" userInfo:nil];
    }];
    self.tableView.layer.shadowColor = [UIColor redColor].CGColor;
    self.tableView.layer.shadowOffset = CGSizeMake(0,0);
    self.tableView.layer.shadowOpacity = 0.5;
    self.tableView.layer.shadowRadius = 10;
    
    
}

#pragma mark tableView代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [TAHappiestAdvisor getCellHeight];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TAHappiestAdvisor * cell = [tableView dequeueReusableCellWithIdentifier:@"TAHappiestAdvisor"];
    if (self.dataSourceArray.count>indexPath.row) {
         cell.model = self.dataSourceArray[indexPath.row];
    }
   
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row==self.dataSourceArray.count-2&&!self.isNoMoreData) {
        NSLog(@"加载下一页的数据");
        [self routerEventWithName:@"loadNextPageData" userInfo:nil];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     if (self.dataSourceArray.count>indexPath.row) {

         CAPreventRepeatClickTime(0.5);
         TASorrowPress * model = self.dataSourceArray[indexPath.row];
         [self routerEventWithName:@"creatOrderAction" userInfo:model];
     }
}


-(void)setDataSourceArray:(NSArray *)dataSourceArray{
    
    if (self.isLoadingData) {
        return;
    }
    
    _dataSourceArray = dataSourceArray;
    
    [self.tableView reloadData];
}

-(void)endFresh{
    [self.tableView.mj_header endRefreshing];
}

-(void)setStateToIdle{
    
    [self.tableView.mj_footer setState:MJRefreshStateIdle];
    self.isNoMoreData = NO;
}

-(void)noMoreData{
    
    self.isNoMoreData = YES;
    [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
}


@end
