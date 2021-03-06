//
//  TAFrontFriends.m
//  JLGP
//
 
//  Copyright © 2019 CA. All rights reserved.
//

#import "TAFrontFriends.h"
#import "TAReplacedTending.h"

static UITextView *textView = nil;

@implementation TAFrontFriends

-(id)init
{
    if (self = [super init]) {
        
        if (textView == nil) {
            textView = [[UITextView alloc] init];
            textView.scrollEnabled = NO;
            textView.font = FONT_REGULAR_SIZE(15);
        }
    }
    
    return self;
}

- (void) setMessageType:(CAMessageType)messageType
{
    
    _messageType = messageType;
    switch (messageType) {
        case CAMessageTypeText:
            self.cellIndentify = @"TAHookedCrying";
            break;
        case CAMessageTypeSystem:
            self.cellIndentify = @"TAElectronicForeign";
        break;
        case CAMessageTypeImage:
            self.cellIndentify = @"TASystemsBrains";
        break;
            
        default:
            break;
    }
}


-(CGSize) messageSize
{
    
    if (_messageSize.width&&_messageSize.height) {
        return _messageSize;
    }
    
    switch (self.messageType) {
            
        case CAMessageTypeText:
//
//            _messageSize = [self.text boundingRectWithSize:CGSizeMake(MainWidth -140, MAXFLOAT)
//               options: NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin
//            attributes:@{NSFontAttributeName:FONT_REGULAR_SIZE(15)}
//               context:nil].size;
//           ;
//
            textView.text=NSStringFormat(@"%@",self.body);
            
            _messageSize = [textView sizeThatFits:CGSizeMake(MainWidth-140, MAXFLOAT)];
            _messageSize.height-=16;
            NSLog(@"%@",NSStringFromCGSize(_messageSize));
            
            break;
            
            case CAMessageTypeSystem:
            
                _messageSize = [self.body boundingRectWithSize:CGSizeMake(MainWidth-100, MAXFLOAT)
                   options: NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin
                attributes:@{NSFontAttributeName:FONT_REGULAR_SIZE(12)}
                   context:nil].size;
                _messageSize.width +=20;//边距 左右都是 10
            
            break;
            
            case CAMessageTypeImage:
            
            NSLog(@"imageSize %@",NSStringFromCGSize(_imageSize));
            if (_imageSize.width&&_imageSize.height) {
                _messageSize = [TAReplacedTending caculateImageSize:_imageSize];
            }else{
                _messageSize = CGSizeMake(1, 1);
            }
            
            break;
            
        default:
            break;
    }
    
    return _messageSize;
}


-(CGFloat) cellHeight
{
    
    switch (self.messageType){
            // cell 上下间隔为10
        case CAMessageTypeText:
            
            return self.messageSize.height + 40 > 60 ? self.messageSize.height + 40 : 40;
            
            break;
        case CAMessageTypeSystem:
       
            return self.messageSize.height + 45+10;
            
        break;
        case CAMessageTypeImage:
        
             return self.messageSize.height +15;
             
         break;
            
        default:
            break;
    }
    
    return 0;
}

+ (instancetype)modelWithData:(NSDictionary *)data{
    
    TAFrontFriends * model = [TAFrontFriends new];
    
    if (data) {
//        "body" : "ccc",
//        "sent_at" : "2020-01-09 19:08:24",
//        "message_type" : "text",
//        "is_my_message" : true
        model.sent_at = NSStringFormat(@"%@",data[@"sent_at"]);
        if ([data[@"message_type"] isEqualToString:@"text"]) {
            model.body = NSStringFormat(@"%@",data[@"body"]);
            model.messageType = CAMessageTypeText;
        }else if ([data[@"message_type"] isEqualToString:@"picture"]){
            
        }
        if ([data[@"is_my_message"] boolValue]) {
            model.ownerTyper = CAMessageOwnerTypeSelf;
        }else{
            model.ownerTyper = CAMessageOwnerTypeOther;
        }
    }
    
//    [model save];
    
    return model;
}

@end
