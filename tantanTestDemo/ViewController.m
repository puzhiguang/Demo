//
//  ViewController.m
//  TTTAttributedLabelTest
//
//  Created by chj on 2017/5/6.
//  Copyright © 2017年 chj. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import "TTFeedbackViewController.h"

@interface ViewController ()<TTTAttributedLabelDelegate>
{
    NSRange _lineboldRange;
    NSRange _lineboldRange1;
}
@property (nonatomic,strong) TTTAttributedLabel * ttLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTTLabel];
    [self configurTTLabel];
    
}

-  (void)initTTLabel{
    _ttLabel = [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(10,80,self.view.frame.size.width-20,50)];
    _ttLabel.numberOfLines = 0;
    _ttLabel.lineSpacing = 10;
    _ttLabel.font = [UIFont systemFontOfSize:13];
    _ttLabel.textColor = [UIColor lightGrayColor];
    _ttLabel.delegate = self;
    //检测url
    _ttLabel.enabledTextCheckingTypes=NSTextCheckingTypeLink;
    //对齐方式
    _ttLabel.verticalAlignment=TTTAttributedLabelVerticalAlignmentTop;
    [self.view addSubview:_ttLabel];
}


- (void)configurTTLabel{
    NSString*tempStr =@"欢迎使用探探, 在使用过程中有疑问请反馈";
    _ttLabel.frame = CGRectMake(10,80,self.view.frame.size.width, 70);
    [_ttLabel setText:tempStr afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString*(NSMutableAttributedString*mutableAttributedString){
        //设置可点击文字的范围
        NSRange boldRange = [[mutableAttributedString string]rangeOfString:@"反馈"options:NSCaseInsensitiveSearch];
        self->_lineboldRange = boldRange;

        //设定可点击文字的的大小
        UIFont *boldSystemFont = [UIFont systemFontOfSize:15];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize,NULL);
        if(font){
            //设置可点击文本的大小
            [mutableAttributedString addAttribute:(NSString*)kCTFontAttributeName value:(__bridge id)font range:boldRange];
            //设置可点击文本的颜色
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blackColor]CGColor] range:boldRange];

            //添加下划线
            [mutableAttributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:boldRange];

            CFRelease(font);
        }
        return mutableAttributedString;
    }];
    NSURL*firstUrl = [NSURL URLWithString:@"tantanapp://feedback"];
    //添加url
    [_ttLabel addLinkToURL:firstUrl withRange:_lineboldRange];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)attributedLabel:(TTTAttributedLabel*)label didSelectLinkWithURL:(NSURL*)url{
    TTFeedbackViewController *vc= [[TTFeedbackViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//    NSLog(@"打印设置的URL%@进行跳转处理",url);
}




@end
