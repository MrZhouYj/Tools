//
//  TAPersonGlobally.m
//  JLGP
//
//   9/24.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAPersonGlobally.h"
#import "TAHumanScenic.h"

@interface TAPersonGlobally()
{
    CGFloat _normalY;
    CGFloat _selY;
    
    CGFloat _normalWidth;
    CGFloat _selWidth;
    
    CGFloat _normalHeight;
    CGFloat _selHeight;
    
}
@property (nonatomic, strong) TAHumanScenic * buyView;

@property (nonatomic, strong) TAHumanScenic * sellView;

@property (nonatomic, strong) TAHumanScenic * selView;

@end

@implementation TAPersonGlobally

-(instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageDidChange) name:CALanguageDidChangeNotifacation object:nil];

        [self initSubViews];
        
        [self languageDidChange];
    }
    return self;
}
-(void)languageDidChange{
    self.buyView.title = @"我要买";
    self.sellView.title = @"我要卖";
}


-(void)initSubViews{
    
    self.buyView = [TAHumanScenic new];
    [self addSubview:self.buyView];
    
    
    self.sellView = [TAHumanScenic new];
    [self addSubview:self.sellView];
   
    _normalY = 10;
    _selY = 0;
    
    _normalWidth = 120;
    _selWidth = 130;
    
    _normalHeight = 31;
    _selHeight = 41;
    
    self.buyView.frame = CGRectMake(15, _selY, _selWidth, _selHeight);
    self.sellView.frame = CGRectMake(125, _normalY, _normalWidth, _normalHeight);
    
    self.buyView.select = YES;
    
    
    
    self.selView = self.buyView;
    
    [self bringSubviewToFront:self.buyView];
    
    [self.buyView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buyClick)]];
    [self.sellView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sellClick)]];
}

-(void)buyClick{
    
    self.buyView.select = YES;
    self.sellView.select = NO;
    
    [self bringSubviewToFront:self.buyView];
    
    CGRect rect = self.buyView.frame;
    self.buyView.frame = CGRectMake(CGRectGetMinX(rect), _selY, _selWidth, _selHeight);
    
    CGRect rect2 = self.sellView.frame;
    self.sellView.frame = CGRectMake(CGRectGetMinX(rect2)+20, _normalY, _normalWidth-20, _normalHeight);
    
    if (self.delegata&&[self.delegata respondsToSelector:@selector(TAPersonGlobally_didSelectedIndex:)]) {
        [self.delegata TAPersonGlobally_didSelectedIndex:@"buy"];
    }
}
-(void)sellClick{
    
   
    CGRect rect = self.sellView.frame;
    self.sellView.frame = CGRectMake(CGRectGetMinX(rect)-20, _selY, _selWidth+20, _selHeight);
    
    CGRect rect2 = self.buyView.frame;
    self.buyView.frame = CGRectMake(CGRectGetMinX(rect2), _normalY, _normalWidth, _normalHeight);
    self.sellView.select = YES;
    self.buyView.select = NO;
    
    [self bringSubviewToFront:self.sellView];
    
    if (self.delegata&&[self.delegata respondsToSelector:@selector(TAPersonGlobally_didSelectedIndex:)]) {
        [self.delegata TAPersonGlobally_didSelectedIndex:@"sell"];
    }
}

@end
