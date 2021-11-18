//
//  ViewController.m
//  contiuedThread-常驻线程
//
//  Created by huashuda on 2021/11/18.
//

#import "ViewController.h"
#import "XMGThread.h"

@interface ViewController ()

@property (nonatomic, strong) XMGThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.thread = [[XMGThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    self.thread.name = @"子线程";
    [self.thread  start];
}

- (void)run
{
    NSLog(@"---run---");
    [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]run];
}

- (void)test
{
    NSLog(@"-----%@",[NSThread currentThread]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

@end
