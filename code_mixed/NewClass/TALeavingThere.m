//
//  TALeavingThere.m
//  JLGP
//
//   10/18.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TALeavingThere.h"
#import "TAFrontFriends.h"
#import "TAHookedCrying.h"
#import "TAWiresAppealing.h"
#import "TAElectronicForeign.h"
#import "TAAlarmPhones.h"
#import "TASystemsBrains.h"
#import "TAReplacedTending.h"
#import "KNPhotoBrowser.h"

@interface TALeavingThere()
<UITableViewDelegate,
UITableViewDataSource,
CAChatBoxDelegate,
TAAlarmPhonesDelegate,
TASuburbanTrainDelegate
>
{
    CGFloat _tableViewDefultHeight;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TAWiresAppealing *boxView;

@property (nonatomic, strong) TAAlarmPhones *headerView;

@property (nonatomic, strong) UIButton * upDownButton;

@property (nonatomic, strong) NSMutableArray <TAFrontFriends *>* messages;

@end

@implementation TALeavingThere

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = HexRGB(0xeeeef4);
        
        [self addSubview:self.headerView];
        [self addSubview:self.tableView];
        [self addSubview:self.boxView];
        _unreadMessagesCount = 0;
        self.delegate = self;
        [self CornerTop];
    }
    return self;
}

-(void)setOrderInfoModel:(TAHappinessAbsorbing *)orderInfoModel{
    _orderInfoModel = orderInfoModel;
    self.headerView.orderInfoModel = orderInfoModel;
}

-(void)thisViewDidAppear:(BOOL)animated{
    self.unreadMessagesCount = 0;
}

-(void)getMessage{
    
        NSDictionary * para = @{
            @"id":NSStringFormat(@"%@",self.ID)
        };
        
        [TACrimeStudy GET:CAAPI_OTC_MESSAGES parameters:para success:^(id responseObject) {
            //刷新数据
            NSLog(@"%@",responseObject);
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([responseObject[@"code"] integerValue]==20000)
                {
                    NSArray * datas = responseObject[@"data"];
                    NSMutableArray * mutData = @[].mutableCopy;
                    for (NSDictionary * dic in datas) {
                        TAFrontFriends * model = [TAFrontFriends modelWithData:dic];
                        [mutData addObject:model];
                    }
                    [self.messages addObjectsFromArray:mutData];
                    [self.tableView reloadData];
                    [self scrollToBottom];
                }
                [self subscribeChat];
            });
            
        } failure:^(NSError *error) {
        }];
}

-(void)subscribeChat{
    [[TAVulnerablePlaces shareSocket] addDelegate:self];
    [[TAVulnerablePlaces shareSocket] sendDataToSever:[self messagesOtc]];
}
-(void)unSubscribeChat{
    [[TAVulnerablePlaces shareSocket] removeDelegate:self];
    [[TAVulnerablePlaces shareSocket] unsubCurrentReq];
}

#pragma mark market_list_app 频道拼接
-(NSDictionary*)messagesOtc{
    NSDictionary * dic = @{
        @"channel" : @"otc_fiat_trading_message",
        @"market_id":NSStringFormat(@"%@",self.ID),
        @"token":NSStringFormat(@"%@",[TAAppreciatePlans currentUser].app_token),
    };
    return [TAVulnerablePlaces getSub:dic];
}

- (void)webSocketDidOpen{
    
    [[TAVulnerablePlaces shareSocket] sendDataToSever:[self messagesOtc]];
}
-(void)webSocket:(TAVulnerablePlaces *)webSocket didReceiveMessage:(NSDictionary *)message{

    if (message[@"channel"]) {
        if ([message[@"channel"] isEqualToString:[self messagesOtc][@"subscribe"]]) {
            NSLog(@"%@",message);
            NSDictionary *msg = message[@"content"];
            if (msg) {
                TAFrontFriends * model = [TAFrontFriends modelWithData:msg];
                [self.messages addObject:model];
                [self.tableView reloadData];
                [self scrollToBottom];
                if (!self.isShowing) {
                    self.unreadMessagesCount++;
                }
            }
        }
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.messages.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    TAFrontFriends  * messageModel = self.messages[indexPath.row];
 
    id cell = [tableView dequeueReusableCellWithIdentifier:messageModel.cellIndentify forIndexPath:indexPath];
  
    [cell setMessageModel:messageModel];
    
    
    return cell;
    
}

#pragma mark - UITableViewCellDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TAFrontFriends *message = [self.messages objectAtIndex:indexPath.row];
    return message.cellHeight;
}

- (void) scrollToBottom
{
    
    if (self.messages.count > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        });
    }
}

#pragma mark 发送消息
- (void)chatBox:(TAWiresAppealing *)chatBox sendTextMessage:(NSString *)textMessage{
    
   
    TAFrontFriends *recMessage = [[TAFrontFriends alloc] init];
    recMessage.messageType = CAMessageTypeText;
    recMessage.ownerTyper = CAMessageOwnerTypeSelf;
    recMessage.date = [NSDate date];// 当前时间
    recMessage.body = textMessage;
  
    [self addNewMessage:recMessage];

    [self scrollToBottom];
    
}

-(void)chatBox:(TAWiresAppealing *)chatBox sendImageMessage:(nonnull UIImage *)imageMessage{
    
    NSLog(@"开始发送图片消息");
    TAFrontFriends *recMessage = [[TAFrontFriends alloc] init];
    recMessage.messageType = CAMessageTypeImage;
    recMessage.ownerTyper = CAMessageOwnerTypeSelf;
    recMessage.date = [NSDate date];// 当前时间
    recMessage = [TAReplacedTending initImageMessage:imageMessage imageMessageModel:recMessage];
    
    [self addNewMessage:recMessage];
    [self scrollToBottom];
    
    NSLog(@"开始发送图片消息  end");
}

- (void) addNewMessage:(TAFrontFriends *)message
{
    NSLog(@"发送文本消息");
    NSDictionary * dic = @{
        @"content":NSStringFormat(@"%@",[TAReplacedTending removeEmoji:message.body]),
        @"id":NSStringFormat(@"%@",self.ID)
    };
    NSLog(@"%@",dic);
    [self.messages addObject:message];
    [self.tableView reloadData];
    
    [TACrimeStudy POST:@"otc/send_text_message"  parameters:dic success:^(id responseObject) {
    
    } failure:^(NSError *error) {
      
    }];
    
    
}

-(void)TAAlarmPhones_hideChatViewClick{
    
    [self hide:YES];
}

- (void)chatBox:(TAWiresAppealing *)chatBox changeChatBoxHeight:(CGFloat)height{
    
    self.tableView.height = _tableViewDefultHeight - height+49+SafeAreaBottomHeight;
    self.boxView.y = self.tableView.height+self.tableView.y;
   
    [self scrollToBottom];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.boxView resignFirstResponder];
}


-(void)routerEventWithName:(NSString *)eventName userInfo:(id)userInfo{
    
    if ([eventName isEqualToString:NSStringFromClass([TASystemsBrains class])]) {
        //发送的消息中图片的点击事件
        TAFrontFriends * curModel = (TAFrontFriends*)userInfo;
        NSMutableArray *tempArr = [NSMutableArray array];
        NSMutableArray *itemsArr = [NSMutableArray array];
        for (NSInteger i = 0; i < self.messages.count; i++) {
            
            TAFrontFriends *model = self.messages[i];
            if (model.messageType == CAMessageTypeImage) {
                KNPhotoItems *items = [[KNPhotoItems alloc] init];
                if (model.originImage) {
                    items.sourceImage = model.originImage;
                }else if(model.imageURL.length){
                    items.url = model.imageURL;
                }
                [tempArr addObject:model];
                [itemsArr addObject:items];
            }
            
        }
        
        NSArray *visibleCells = self.tableView.visibleCells;
        
        for (NSInteger i = 0; i < itemsArr.count; i++) {
            KNPhotoItems *items = itemsArr[i];
            TAFrontFriends *model = tempArr[i];
            
            for (NSInteger j = 0; j < visibleCells.count; j++) {
                id cell = visibleCells[j];
                if ([cell isKindOfClass:[TASystemsBrains class]]) {
                    TASystemsBrains *cell = (TASystemsBrains *)visibleCells[j];
                    if(cell.messageModel.originImage == nil && cell.messageModel.imageURL == nil){
                        
                    }else{
                        if(model == cell.messageModel){
                            items.sourceView = cell.messageImageView;
                        }
                    }
                }
            }
        }
        
        KNPhotoBrowser *photoBrower = [[KNPhotoBrowser alloc] init];
        photoBrower.itemsArr = itemsArr;
        photoBrower.isNeedPageControl = true;
        photoBrower.isNeedPanGesture  = true;
        photoBrower.currentIndex = [tempArr indexOfObject:curModel];
        [photoBrower present];
    }
}

-(TAAlarmPhones *)headerView{
    if (!_headerView) {
        _headerView = [[TAAlarmPhones alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 120)];
        
        _headerView.delegate = self;
        _headerView.backgroundColor = HexRGB(0xf7f6fb);
    }
    return _headerView;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        
        _tableViewDefultHeight = self.height-49-SafeAreaBottomHeight-self.headerView.height;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.height, MainWidth, _tableViewDefultHeight) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setTableFooterView:[UIView new]];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.backgroundColor = [UIColor clearColor];
        
        [_tableView registerClass:[TAHookedCrying class] forCellReuseIdentifier:@"TAHookedCrying"];
         [_tableView registerClass:[TAElectronicForeign class] forCellReuseIdentifier:@"TAElectronicForeign"];
        [_tableView registerClass:[TASystemsBrains class] forCellReuseIdentifier:@"TASystemsBrains"];
        
        [_tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTapClick)]];
    }
    return _tableView;
}

-(void)tableViewTapClick{
    [self.boxView resignFirstResponder];
}


-(TAWiresAppealing *)boxView{
    if (!_boxView) {
        _boxView = [[TAWiresAppealing alloc] initWithFrame:CGRectMake(0, self.tableView.height+self.tableView.y, MainWidth, 49)];
        [_boxView setDelegate:self];
        
        //用来填充x底部的34
        UIView * lineView = [UIView new];
        [self addSubview:lineView];
        
        lineView.frame = CGRectMake(0, _boxView.ly_maxY, MainWidth, SafeAreaBottomHeight);
        lineView.backgroundColor = _boxView.backgroundColor;
        
        _boxView.viewController = self.viewController;
    }
    return _boxView;
}


-(NSMutableArray<TAFrontFriends *> *)messages{
    if (!_messages) {
        _messages = @[].mutableCopy;
    }
    return _messages;
}

@end
