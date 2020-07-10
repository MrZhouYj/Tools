//
//  TABecomeHowever.m
//  JLGP
//
//  Created by  on 2019/12/19.
//  Copyright © 2019 CA. All rights reserved.
//

#import "TABecomeHowever.h"

@interface TABecomeHowever ()

@property (weak, nonatomic) IBOutlet UIImageView *logoTextImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameZHLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameENLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation TABecomeHowever

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.versionLabel.text = NSStringFormat(@"Version %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]);

}


@end
