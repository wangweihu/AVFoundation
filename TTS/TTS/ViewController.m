//
//  ViewController.m
//  TTS
//
//  Created by 王伟虎 on 2018/9/4.
//  Copyright © 2018年 王伟虎. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property(nonatomic, strong) AVSpeechSynthesizer *speechSynthesizer;
@property(nonatomic, strong) AVSpeechUtterance *utterance;
@property(nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    [self commonInit];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commonInit {
    UISwitch *senderSwitch = [[UISwitch alloc] init];
    senderSwitch.on = YES;
    senderSwitch.frame = CGRectMake(0, 0, 100, 20);
    senderSwitch.center = self.view.center;
    [senderSwitch addTarget:self action:@selector(updateUtterance:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:senderSwitch];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 200)/2.0f, CGRectGetMaxY(senderSwitch.frame) - 80, 200, 20)];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((self.view.bounds.size.width - 128)/2.0f, CGRectGetMaxY(senderSwitch.frame) + 20, 128, 128);
    [btn setImage:[UIImage imageNamed:@"audio"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self updateUtterance:senderSwitch];
}

- (void)updateUtterance:(UISwitch *)sender {
    sender.on = !sender.isOn;
    if (sender.on) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"Tsutsumi"];
        // 这里的国际音标可以随意修改 eg:"tən.tən.mə"  "tən.mə" ... 可以多试试其他的情况
        [attString addAttribute:AVSpeechSynthesisIPANotationAttribute value:@"tən.tən.mi" range:NSMakeRange(0, attString.length)];
        self.utterance = [AVSpeechUtterance speechUtteranceWithAttributedString:attString];
        
        self.label.text = @"Tsutsumi(Attributed)";
    } else {
        self.utterance = [AVSpeechUtterance speechUtteranceWithString:@"Tsutsumi"];
        self.label.text = @"Tsutsumi";
    }
}

- (void)btnClick:(UIButton *)sender {
    if (self.speechSynthesizer.isSpeaking) {
        NSLog(@"正在说话中....");
        return;
    }
    [self.speechSynthesizer speakUtterance:self.utterance];
}

@end
