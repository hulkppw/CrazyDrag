//
//  ViewController.m
//  CrazyDrag
//
//  Created by Vincen on 16/1/7.
//  Copyright © 2016年 Vincen. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"
#import "AVFoundation/AVFoundation.h"

@interface ViewController (){
    int currentValue;
    int targetValue;
    int score;
    int round;
}

- (IBAction)sliderMoved:(UISlider*)sender;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
- (IBAction)startOver:(id)sender;

- (IBAction)showAlert:(id)sender;


- (void)viewDidLoad;
- (IBAction)showInfo:(id)sender;


@end

@implementation ViewController
@synthesize slider;
@synthesize targetLabel;
@synthesize audioPlayer;

//添加背景音乐
- (void)playBackgroundMusic{
    NSString *musicPath = [[NSBundle mainBundle]pathForResource:@"no" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    if(audioPlayer == nil){
        NSString *errorInfo = [NSString stringWithString:[error description]];
        NSLog(@"the error is:%@", errorInfo);
    }else{
        [audioPlayer play];
    }
    
    
}

- (IBAction)sliderMoved:(UISlider*)sender {
    UISlider *slider = (UISlider*)sender;
    //NSLog(@"滑动条当前的数值时：%f",slider.value);
    currentValue = (int)lroundf(sender.value);
}


//弹窗
- (IBAction)startOver:(id)sender {
    //添加过度效果
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
    
}
-(void)startNewGame{
    score=0;
    round = 0;
    [self startNewRound];
}
- (IBAction)showAlert:(id)sender{
    /*int difference;
    if(targetValue>currentValue){
        difference = targetValue-currentValue;
    }else if(targetValue<currentValue){
        difference = currentValue-targetValue;
    }else{
        difference = 0;
    }*/
    int difference = abs(targetValue-currentValue);
    int points = 100 - difference;
    
    NSString *title;
    if(difference==0){
        title=@"土豪你太NB了";
        points += 100;
    }else if(difference<5){
        title=@"土豪太棒了，差一点";
        points += 50;
    }else if (difference<10){
        title=@"好吧，勉强算个土豪";
    }else{
        title=@"不是土豪少来装";
    }
    score += points;
    NSString *message = [NSString stringWithFormat:@"恭喜高富帅，您的得分是：%d",points];
    [[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"朕已知晓" otherButtonTitles:nil, nil]show];
    //[self startNewRound];
    //[self updateLabels];
}
//更新目标标签显示值
- (void)updateLabels{
    self.targetLabel.text=[NSString stringWithFormat:@"%d",targetValue];
    self.scoreLabel.text=[NSString stringWithFormat:@"%d",score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d",round];
}
//开始下一轮
- (void)startNewRound
{
    targetValue = 1+(arc4random()%100);
    currentValue = 50;
    round++;
    self.slider.value=currentValue;
    //[self playBackgroundMusic];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //currentValue=self.slider.value;
    UIImage *thumbImageNormal=[UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    UIImage *thumbImageHighlighted=[UIImage imageNamed:@"SliderThumbHighlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    UIImage *trackLeftImage=[[UIImage imageNamed:@"SliderTrackLeft"]stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    //currentValue = 50;
    [self startNewGame];
    [self updateLabels];
    //[self playBackgroundMusic];
    
}

- (IBAction)showInfo:(id)sender {
    AboutViewController *controller=[[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}
//弹出框关闭之后的操作
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self startNewRound];
    [self updateLabels];
}
@end
