//
//  TAHookedCrying.m
//  JLGP
//
 
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAHookedCrying.h"
#import "TASecurityAutonomous.h"

@interface TAHookedCrying()

@property (nonatomic, strong) TASecurityAutonomous * messageTextLabel;

@end

@implementation TAHookedCrying


- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.messageTextLabel];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    float y = self.avatarImageView.y + 10;
    float x = self.avatarImageView.x + (self.messageModel.ownerTyper == CAMessageOwnerTypeSelf ? - self.messageTextLabel.width - 27 : self.avatarImageView.width + 24);
    
    [self.messageTextLabel setOrigin:CGPointMake(x, y)];
                                       // 左边距离头像 5
    y = self.avatarImageView.y;       // 上边与头像对齐
    float h = MAX(self.messageTextLabel.height+20, self.avatarImageView.height);
    x = self.messageModel.ownerTyper == CAMessageOwnerTypeSelf ?self.messageTextLabel.x-15:self.avatarImageView.x+self.avatarImageView.width+5;
    
    float width = self.messageTextLabel.width+20+15;
    
    [self.messageBackgroundImageView setFrame:CGRectMake(x, y, width, h)];
    
}

-(void)setMessageModel:(TAFrontFriends *)messageModel
{

    [super setMessageModel:messageModel];
    
    [self.messageTextLabel setText:messageModel.body];
     self.messageTextLabel.size = messageModel.messageSize;
    
    switch (messageModel.ownerTyper) {
        case CAMessageOwnerTypeSelf:
            self.messageTextLabel.textColor = HexRGB(0xf3f5ff);
            break;
         
        case CAMessageOwnerTypeOther:
            self.messageTextLabel.textColor = HexRGB(0x191d26);
            break;
            
        default:
            
            break;
    
    }
}

- (TASecurityAutonomous *) messageTextLabel
{
    if (_messageTextLabel == nil) {
        _messageTextLabel = [[TASecurityAutonomous alloc] init];
        [_messageTextLabel setFont:FONT_REGULAR_SIZE(15)];
        _messageTextLabel.editable = NO;
        _messageTextLabel.backgroundColor =  [UIColor clearColor];
        _messageTextLabel.scrollEnabled  = NO;
        _messageTextLabel.textContainerInset = UIEdgeInsetsZero;
    
    }
    return _messageTextLabel;
}


@end
