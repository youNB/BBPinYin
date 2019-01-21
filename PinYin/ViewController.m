//
//  ViewController.m
//  PinYin
//
//  Created by 程肖斌 on 2019/1/21.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import "ViewController.h"
#import "BBPinyinManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *text_field;
@property (weak, nonatomic) IBOutlet UILabel     *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)convert:(UIButton *)sender {
    NSString *text   = self.text_field.text;
    NSString *result = [BBPinyinManager.sharedManager convertChinese:text];
    self.label.text  = result;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
