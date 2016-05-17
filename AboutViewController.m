//
//  AboutViewController.m
//  CrazyDrag
//
//  Created by Vincen on 16/1/14.
//  Copyright © 2016年 Vincen. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
- (IBAction)close:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation AboutViewController
@synthesize webview;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *htmlFile = [[NSBundle mainBundle]pathForResource:@"CrazyDrag" ofType:@"html"];
    NSData *htmlData=[NSData dataWithContentsOfFile:htmlFile];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]];
    [self.webview loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)close:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
