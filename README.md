# HTTaskManager
osx执行shell脚本,可执行root命令.
#用例

HTTaskManager是一个单例对象,直接调用方法即可,代码中有注释.
```
[[HTTaskManager sharedManager] execShellCMDAsAdmin:_txf.stringValue completeBlock:^(NSString *resultStr, NSString *errorStr) {
        NSLog(@"result => %@ , error => %@",resultStr,errorStr);
        self.textView.string = [NSString stringWithFormat:@"result:\n%@,\nerror:\n%@",resultStr,errorStr];
        
    }];
```
