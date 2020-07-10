//
//  CAAgentViewController.m
//  JLGP
//
//  Created by 周永建 on 2020/6/29.
//  Copyright © 2020 CA. All rights reserved.
//

#import "CAAgentViewController.h"

@interface CAAgentViewController ()
{
    NSInteger _index;
}
@property (weak, nonatomic) IBOutlet UILabel *agentPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *agentValue;
@property (weak, nonatomic) IBOutlet UILabel *agentCodeNotiLabel;
@property (weak, nonatomic) IBOutlet UILabel *agentCodeLabel;
@property (nonatomic, strong) UIButton * saveButton;

@property (nonatomic, strong) NSArray *agents;

@property (nonatomic, copy) NSString * agent_code;
@property (weak, nonatomic) IBOutlet UIImageView *rightRowImageView;

@end

@implementation CAAgentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAUser * currentUser = [CAUser currentUser];
    if (currentUser.is_agent) {
        self.navcTitle = @"经纪人信息";
        self.agentPersonLabel.text = CALanguages(@"经纪人");
        self.agentCodeNotiLabel.text = CALanguages(@"经纪人代码");
        self.agentValue.text = [NSString stringWithFormat:@"%@",currentUser.have_agent_or_not];
        self.agentCodeLabel.text = [NSString stringWithFormat:@"%@",currentUser.have_agent_code_or_not];
        self.rightRowImageView.hidden = YES;
    }else{
        self.navcTitle = @"选择经纪人";
        self.agentPersonLabel.text = CALanguages(@"选择经纪人");
        self.agentCodeNotiLabel.text = CALanguages(@"经纪人代码");
        self.agentValue.text = CALanguages(@"请选择");
        self.saveButton = [CABaseButton buttonWithTitle:@"保存"];
        [self.view addSubview:self.saveButton];
        [self.saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15);
            make.bottom.equalTo(self.view).offset(-(15+SafeAreaBottomHeight));
            make.height.equalTo(@45);
        }];
        
        [self.agentValue addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseAction)]];
        
        [self getData];
    }
    
    
}

-(void)chooseAction{
    
    [CAActionSheetView showActionSheet:self.agents key:@1 selectIndex:_index click:^(id  _Nonnull value, NSInteger index) {
        
        self->_index = index;
        self.agent_code = [value firstObject];
        self.agentValue.text = [value lastObject];
        self.agentCodeLabel.text = [value firstObject];
        
        if (self.agent_code.length) {
            self.saveButton.enabled = YES;
        }else{
            self.saveButton.enabled = NO;
        }
    }];
}

-(void)getData{
    
    [SVProgressHUD show];
    [CANetworkHelper GET:CAAPI_MINE_GET_AGENT_DATA parameters:nil success:^(id responseObject) {
        [SVProgressHUD dismiss];
        
        self.agents = responseObject[@"data"];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

-(void)save{
    
    if (!_agent_code.length) {
        return;
    }
    
    NSDictionary * para = @{
        @"agent_code": _agent_code
    };
    
    [SVProgressHUD show];
    [CANetworkHelper POST:CAAPI_MINE_IMPROVE_INFORMATION parameters:para success:^(id responseObject) {
       
        [SVProgressHUD dismiss];
        [CAUser currentUser].have_agent_code_or_not = self->_agent_code;
        Toast(responseObject[@"message"]);
        if ([responseObject[@"code"] integerValue] == 20000) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

@end
