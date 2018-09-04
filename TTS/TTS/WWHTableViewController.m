//
//  WWHTableViewController.m
//  TTS
//
//  Created by 王伟虎 on 2018/9/4.
//  Copyright © 2018年 王伟虎. All rights reserved.
//

#import "WWHTableViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface WWHTableViewController ()

@property(nonatomic, strong) NSMutableArray *speechVoices;
@property(nonatomic, strong) AVSpeechSynthesizer *speechSynthesizer;
@property(nonatomic, strong) AVSpeechUtterance *utterance;

@end

@implementation WWHTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.speechVoices = @[].mutableCopy;
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    self.utterance = [AVSpeechUtterance speechUtteranceWithString:@"Hello iPhone"];
    
    self.speechVoices = [AVSpeechSynthesisVoice speechVoices].mutableCopy;
    AVSpeechSynthesisVoice *alexVoice = [AVSpeechSynthesisVoice voiceWithIdentifier:AVSpeechSynthesisVoiceIdentifierAlex];
    if (alexVoice) {
        [self.speechVoices insertObject:alexVoice atIndex:0];
    } else {
        NSLog(@"AVSpeechSynthesisVoiceIdentifierAlex couldn't be instantiated.");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.speechVoices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    // Configure the cell...
    AVSpeechSynthesisVoice *voice = [self.speechVoices objectAtIndex:indexPath.row];
    cell.textLabel.text = voice.name;
    cell.textLabel.textColor = [UIColor blueColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"lang:%@ quality:%@ identifier:%@", voice.language, (voice.quality == AVSpeechSynthesisVoiceQualityDefault)?@"Default":@"Enhanced", voice.identifier];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AVSpeechSynthesisVoice *voice = [self.speechVoices objectAtIndex:indexPath.row];
    self.utterance.voice = voice;
    
    if (self.speechSynthesizer.isSpeaking) {
        NSLog(@"正在朗读中....");
        return;
    }
    [self.speechSynthesizer speakUtterance:self.utterance];
}

@end
