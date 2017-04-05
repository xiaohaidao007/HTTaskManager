//
//  ViewController.m
//  ExecShellCMD
//
//  Created by  guogh on 2017/4/5.
//  Copyright © 2017年  guogh. All rights reserved.
//

#import "ViewController.h"
#import "HTTaskManager.h"

@interface ViewController ()
@property (weak) IBOutlet NSTextField *txf;
@property (weak) IBOutlet NSScrollView *scrollView;
@property(weak,nonatomic)NSTextView *textView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView = (NSTextView *)self.scrollView.documentView;
    _textView.editable = NO;
}

- (IBAction)clickButton:(id)sender {
    if (_txf.stringValue.length == 0) {
        return;
    }
    [[HTTaskManager sharedManager] execShellCMDWith:_txf.stringValue completeBlock:^(NSString *resultStr, NSString *errorStr) {
        NSLog(@"result => %@ , error => %@",resultStr,errorStr);
        NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"$ => %@\n",_txf.stringValue] attributes:@{NSForegroundColorAttributeName:[NSColor redColor],NSFontAttributeName:[NSFont systemFontOfSize:18]}];
        NSAttributedString *resultStrM = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",resultStr] attributes:@{NSForegroundColorAttributeName:[NSColor blackColor]}];
        [strM appendAttributedString:resultStrM];
//        NSLog(@"attM = %@",strM);
        [self.textView.textStorage insertAttributedString:strM atIndex:self.textView.attributedString.length];
    }];
}
- (IBAction)clickRootButton:(id)sender {
    if (_txf.stringValue.length == 0) {
        return;
    }
    [[HTTaskManager sharedManager] execShellCMDAsAdmin:_txf.stringValue completeBlock:^(NSString *resultStr, NSString *errorStr) {
        NSLog(@"result => %@ , error => %@",resultStr,errorStr);
        self.textView.string = [NSString stringWithFormat:@"result:\n%@,\nerror:\n%@",resultStr,errorStr];
        
    }];

}
- (IBAction)clickClearButton:(id)sender {
    
    self.textView.string = @"";
}


- (void)alertWithMessage:(NSString *)msg{
    NSAlert *alert = [NSAlert new];
    [alert addButtonWithTitle:@"确定"];
//    [alert addButtonWithTitle:@"取消"];
    [alert setMessageText:@"运行错误"];
    [alert setInformativeText:msg];
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert beginSheetModalForWindow:[self.view window] completionHandler:^(NSModalResponse returnCode) {
        if(returnCode == NSAlertFirstButtonReturn){
            NSLog(@"确定");
        }else if(returnCode == NSAlertSecondButtonReturn){
            NSLog(@"删除");
        }
    }];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
