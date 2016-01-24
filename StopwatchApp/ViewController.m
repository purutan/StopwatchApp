//
//  ViewController.m
//  StopwatchApp
//
//  Created by 藤田 優介 on 2016/01/22.
//  Copyright © 2016年 YusukeF Inc. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () {

    //スタート・ストップボタン
    UIButton *button1;
    
    //リセットボタン
    UIButton *resetButton;
    
    //時刻を表示するためのラベルインスタンスを格納するための変数
    UILabel *timeLabel;
    
    //背景画像を表示するためのイメージビューインスタンスを格納するための変数
    UIImageView *backgroundView;
    
    //タイマーインスタンス
    NSTimer *timer;

    NSInteger *timeFlag;
    
    NSInteger timeSum;
    
    NSInteger buttonFlag;
}

@end

@implementation ViewController

- (void)setupParts {
    // 背景画像を設定
    backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 284, 284)];
    backgroundView.center = CGPointMake(160, 235);
    backgroundView.image = [UIImage imageNamed:@"maru.png"];
    
    //イメージビューを貼り付ける
    [self.view addSubview:backgroundView];
    
    //ラベルを作成
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    timeLabel.center = CGPointMake(160, 240);
    
    // ラベルに表示するフォントと文字サイズの設定
    timeLabel.font = [UIFont fontWithName:@"Verdana" size:32];
    
    // ラベルに表示する文字を設定
    timeLabel.text = @"00:00";
    
    // ラベルの文字寄せを設定
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    // ラベルの背景色を透明に設定
    timeLabel.backgroundColor = [UIColor clearColor];
    
    // ラベルを画面に貼付ける
    [self.view addSubview:timeLabel];
    
    
    
    
    UIButton *buttonStrStp = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonStrStp.frame = CGRectMake(0, 0, 100, 100);
    buttonStrStp.center = CGPointMake(70, 450);
    
    //[buttonStrStp setTitle:@"START" forState:UIControlStateNormal];
    //[buttonStrStp setTitle:@"START" forState:UIControlStateHighlighted];
    [buttonStrStp setBackgroundImage:[UIImage imageNamed:@"btn_start_001.png" ]forState:UIControlStateNormal];
    [buttonStrStp setBackgroundImage:[UIImage imageNamed:@"btn_start_004.png"] forState:UIControlStateHighlighted];
    
    //[buttonStrStp setTitle:@"STOP" forState:UIControlStateNormal | UIControlStateSelected];  //normal selected
    //[buttonStrStp setTitle:@"STOP" forState:UIControlStateHighlighted | UIControlStateSelected]; // high selected
    [buttonStrStp setBackgroundImage:[UIImage imageNamed:@"btn_stop_003.png" ]forState:UIControlStateNormal | UIControlStateSelected];
    [buttonStrStp setBackgroundImage:[UIImage imageNamed:@"btn_stop_006.png" ]forState:UIControlStateHighlighted | UIControlStateSelected];
    
    [buttonStrStp addTarget:self action:@selector(timeStrStp:) forControlEvents:UIControlEventTouchUpInside ];
    [buttonStrStp addTarget:self action:@selector(mySwitchDidTap:) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:buttonStrStp];
    
    UIButton *buttonReset = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonReset.frame = CGRectMake(0, 0, 100, 100);
    buttonReset.center = CGPointMake(250, 450);
    [buttonReset setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonReset setTitle:@"RESET" forState:UIControlStateNormal];
    [buttonReset setBackgroundImage:[UIImage imageNamed:@"buttonReset.png"] forState:UIControlStateNormal];
    [buttonReset addTarget:self action:@selector(timeReset:) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:buttonReset];

     
    
}

-(void)mySwitchDidTap:(UIButton *)sender
{
    sender.selected = !sender.selected;
    //この部分の流れがいまいち理解してない
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //ラベルとイメージビューを作成するメソッドの呼び出し
    [self setupParts];
    buttonFlag = 0;
}

-(void)tick:(NSTimer*)timer{
    timeSum = timeSum + 1;
    NSString *timeStr = [NSString stringWithFormat:@"%02ld:%02ld",timeSum/60,timeSum%60];
    
    timeLabel.text = timeStr;
    //[timeLabel setText:timeStr];
    //⬆︎同じだが、上はプロパティの値を変える　したはタイムラベルに対する命令
    //上が推奨
}

-(void)timeStrStp:(id)sender{
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:)
                                               userInfo:nil repeats:YES];
    } else if (timer != nil){
        [timer invalidate];
        timer = nil;
    }
}

-(void)timeReset:(id)sender{
    if (timer == nil) {
        timeSum = 0;
        NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d",00,00];
        //　%02d としているのはなぜか　%02ld と上はしているのに
        timeLabel.text = timeStr;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
