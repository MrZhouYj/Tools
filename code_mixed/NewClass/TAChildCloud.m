//
//  TAChildCloud.m
//  JLGP
//
//  Created by  on 2019/12/25.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAChildCloud.h"

@implementation TAChildCloud


-(void)awakeFromNib{
    [super awakeFromNib];
   
    self.contentLabel.font = FONT_REGULAR_SIZE(15);
    self.contentLabel.textColor= RGB(171, 175, 204);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageDidChange) name:CALanguageDidChangeNotifacation object:nil];
    
    [self languageDidChange];
}

-(void)languageDidChange{
    self.contentLabel.text = CALanguages(@"暂无记录");
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
