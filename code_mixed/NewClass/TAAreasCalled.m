//
//  TAAreasCalled.m
//  JLGP
//
//   10/22.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAAreasCalled.h"

@interface CAActionCell()

@property (nonatomic, strong) UILabel * label;

@end

@implementation CAActionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.label];
        
        UIView * lineView = [UIView new];
        [self addSubview:lineView];
        
        lineView.dk_backgroundColorPicker = DKColorPickerWithKey(LineColor);
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@0.5);
        }];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

-(void)setText:(NSString *)text{
    _text = text;
    self.label.text = text;
}

-(void)setIsHightLight:(BOOL)isHightLight{
    _isHightLight = isHightLight;
    if (isHightLight) {
        self.label.textColor = HexRGB(0x0a6cdb);
    }else{
        self.label.textColor = [UIColor blackColor];
    }
}

-(UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = FONT_SEMOBOLD_SIZE(14);
        
    }
    return _label;
}

@end

@interface TAAreasCalled()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, copy) Block block;

@property (nonatomic, copy) void (^blockOld)(NSInteger);

@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, assign) NSInteger selIndex;

@property (nonatomic) id key;

@end

@implementation TAAreasCalled

+(instancetype)showActionSheet:(NSArray *)data selectIndex:(NSInteger)index click:(void (^)(NSInteger))block{
    
    BOOL canScroll = NO;
    CGFloat height = data.count*49+49+5+SafeAreaBottomHeight;
    if (height>MainHeight*0.8) {
        height = MainHeight*0.8;
        canScroll = YES;
    }
    TAAreasCalled * actionSheetView = [[TAAreasCalled alloc] initWithFrame:CGRectMake(0, MainHeight-height, MainWidth, height)];
    
    actionSheetView.blockOld = block;
    actionSheetView.dataArray = data;
    actionSheetView.selIndex = index;
    [actionSheetView CornerTop];
    actionSheetView.canScroll = canScroll;
    [actionSheetView initSubViews];
    
    [actionSheetView showInView:[[UIApplication sharedApplication] keyWindow] isAnimation:YES direaction:CABaseAnimationDirectionFromBottom];
    
    
    return actionSheetView;
}


+(instancetype)showActionSheet:(NSArray *)data key:(NSString *)key selectIndex:(NSInteger)index click:(nonnull Block)block{
    
    BOOL canScroll = NO;
    CGFloat height = data.count*49+49+5+SafeAreaBottomHeight;
    if (height>MainHeight*0.8) {
        height = MainHeight*0.8;
        canScroll = YES;
    }
    TAAreasCalled * actionSheetView = [[TAAreasCalled alloc] initWithFrame:CGRectMake(0, MainHeight-height, MainWidth, height)];
    
    actionSheetView.block = block;
    actionSheetView.key = key;
    actionSheetView.dataArray = data;
    actionSheetView.selIndex = index;
    [actionSheetView CornerTop];
    actionSheetView.canScroll = canScroll;
    [actionSheetView initSubViews];
    
    [actionSheetView showInView:[[UIApplication sharedApplication] keyWindow] isAnimation:YES direaction:CABaseAnimationDirectionFromBottom];
    
    
    return actionSheetView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CAActionCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CAActionCell class]) forIndexPath:indexPath];
    
    cell.isHightLight = self.selIndex == indexPath.row;
    cell.text = [self getIndexValue:indexPath.row];
    
    return cell;
}

-(id)getIndexValue:(NSInteger)index{
    
    id value = self.dataArray[index];
    
    if (!self.key) {
        return value;
    }else if ([self.key isKindOfClass:[NSString class]]&&[value isKindOfClass: [NSDictionary class]]) {
        return [value objectForKey:self.key];
    }else if([self.key isKindOfClass:[NSNumber class]]&&[value isKindOfClass: [NSArray class]]){
        return value[[self.key integerValue]];
    }else{
        return @"";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self hide:YES];
    
    if (indexPath.row == self.selIndex) {
        return;
    }
    if (self.block) {
        self.block(self.dataArray[indexPath.row],indexPath.row);
    }
    if (self.blockOld) {
        self.blockOld(indexPath.row);
    }
}

-(void)initSubViews{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self addSubview:_tableView];
    [_tableView registerClass:[CAActionCell class] forCellReuseIdentifier:NSStringFromClass([CAActionCell class])];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = self.canScroll;
    
    
    UIButton * cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:cancleButton];
    [cancleButton setTitle:CALanguages(@"取消")  forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleButton.titleLabel.font = FONT_SEMOBOLD_SIZE(14);
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-SafeAreaBottomHeight);
        make.left.right.equalTo(self);
        make.height.equalTo(@(49));
    }];
    [cancleButton addTarget:self action:@selector(hideSelf) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * lineView = [UIView new];
    [self addSubview:lineView];
    lineView.dk_backgroundColorPicker = DKColorPickerWithKey(LineColor);
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@5);
        make.bottom.equalTo(cancleButton.mas_top);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(lineView.mas_top);
    }];
    
}

-(void)hideSelf{
    [self hide:YES];
}

@end
