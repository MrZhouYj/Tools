
//
//  TAAnnouncingHelpful.m
//  JLGP
//
//   9/16.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAAnnouncingHelpful.h"
#import "TAUnderSnowball.h"

@interface TAAnnouncingHelpful()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation TAAnnouncingHelpful

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.tableFooterView = [UIView new];
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[TAUnderSnowball class] forCellReuseIdentifier:@"TAUnderSnowball"];
        self.ignoreScrollDelegate = NO;
        [self setBackgroundColor:[UIColor clearColor]];
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

-(void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray;
    
    [self reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TAUnderSnowball * cell = [tableView dequeueReusableCellWithIdentifier:@"TAUnderSnowball"];
    cell.cellStyle = self.tableViewCellStyle;
    cell.showInHome = self.showInHome;
    if (indexPath.row<self.dataArray.count) {
        cell.model = self.dataArray[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.delegata&&[self.delegata respondsToSelector:@selector(tableViewDidSelectedCell:)]) {
        if (self.dataArray.count>indexPath.row) {
            [self.delegata tableViewDidSelectedCell:self.dataArray[indexPath.row]];
        }
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (!self.ignoreScrollDelegate) {
        if (!self.tableViewCanScroll) {
            scrollView.contentOffset = CGPointZero;
            return;
        }
        if (scrollView.contentOffset.y <= 0) {
            //        if (!self.fingerIsTouch) {
            //            return;
            //        }
            self.tableViewCanScroll = NO;
            scrollView.contentOffset = CGPointZero;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
        }
        self.showsVerticalScrollIndicator = _tableViewCanScroll?YES:NO;
    }
}

-(void)hideEmptyView{
 
//     self.ly_emptyView.autoShowEmptyView = NO;
//    [self.ly_emptyView setHidden:YES];
    
}

@end
