//
//  ViewController.m
//  线程
//
//  Created by BMW on 2018/3/6.
//  Copyright © 2018年 tsouTSoutsou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) NSUInteger ticketSurplusCount;

@end


@implementation ViewController
{
    dispatch_semaphore_t semaphoreLock;
}
//串行列队创建方法
- (void) chuanXing{
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"%@",queue);
    
    
}
//并发列队创建方法
- (void)bingXing{
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"%@",queue);

    
}
//主列队获取方法
- (void) getMainQueue{
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    NSLog(@"%@",queue);

}
//全局并发队列的获取
- (void) quanJuQueue{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"%@",queue);
}

//dispatch_group线程同步
- (void) groupSync{
    //创建一个并发队列
    dispatch_queue_t disqueue = dispatch_queue_create("com.shidaiyinuo.NetWorkStudy", DISPATCH_QUEUE_CONCURRENT);
    //创建一个线程同步
    dispatch_group_t disgruop = dispatch_group_create();
    //任务异步添加到队列
    dispatch_group_async(disgruop, disqueue, ^{
        
    });
}

//同步执行 + 并发队列
- (void) syncAndConcurrent{
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    
    //创建一个并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.ceshi.tsou", DISPATCH_QUEUE_CONCURRENT);
    //添加同步任务一
    dispatch_sync(queue, ^{
        //模拟耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    //添加同步任务二
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    //添加同步任务三
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
}

//异步执行 + 并发队列
- (void)asyncAndConcurrent{
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    
    //创建一个并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.ceshi.tsou", DISPATCH_QUEUE_CONCURRENT);
    //添加异步任务一
    dispatch_async(queue, ^{
        //模拟耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    //添加异步任务二
    dispatch_async(queue, ^{
        //模拟耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    
    //添加异步任务三
    dispatch_async(queue, ^{
        //模拟耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
}

//同步执行 + 串行队列
- (void)syncAndSerial{
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.ceshi.tsou", DISPATCH_QUEUE_SERIAL);
    
    //添加同步任务一
    dispatch_sync(queue, ^{
        //模拟耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    //添加同步任务二
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    //添加同步任务三
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
}

//异步执行 + 串行队列
- (void)asyncAndSerial{
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.ceshi.tsou", DISPATCH_QUEUE_SERIAL);
    
    //添加异步任务一
    dispatch_async(queue, ^{
        //模拟耗时操作
        for (int i = 0; i < 3; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    //添加异步任务二
    dispatch_async(queue, ^{
        //模拟耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    
    //添加异步任务三
    dispatch_async(queue, ^{
        //模拟耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
}

//同步执行 + 主队列
- (void)syncAndMain{
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    
    //创建一个主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    //添加同步任务
    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    dispatch_sync(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    dispatch_sync(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
}

//异步执行 + 主队列
- (void)asyncAndMain{
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    NSLog(@"asyncAndMain------begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        //添加任务1
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------ %@",[NSThread currentThread]);
        }
        //追加任务2
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    //追加任务3
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3------%@",[NSThread currentThread]);
    }
    NSLog(@"asyncAndMain------end");
}
//线程间通信
- (void)communication{
    //获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //获取主队列
    dispatch_queue_t mainQueue =  dispatch_get_main_queue();

    //异步追加任务
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    //异步追加任务
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    //回到主线程
    dispatch_async(mainQueue, ^{
        //追加到主线程中完成的任务
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
}

//GCD栏栅方法；dispatch_barrier_async
- (void)barrier{
    //创建一个并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.ceshi.tsou", DISPATCH_QUEUE_CONCURRENT);
    //添加任务一
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1------%@",[NSThread currentThread]);
    });
    
    //添加任务二
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2------%@",[NSThread currentThread]);
    });
    
    //添加栏栅方法
    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"barrier------%@",[NSThread currentThread]);
    });
    
    //添加任务三
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3------%@",[NSThread currentThread]);
    });
    
    //添加任务四
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4------%@",[NSThread currentThread]);
    });
    
}

//GCD延时方法：dispatch_after
- (void)after{
    //
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    NSLog(@"asyncMain------begin");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //2秒后追加任务到主队列 并开始执行
        NSLog(@"after------%@",[NSThread currentThread]);
    });
}

//GCD单例方法
- (void)once{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"啦啦啦");
    });
    
}

//GCD快速迭代方法:dispatch_apply
- (void)apply{
    //获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"apply------begin");
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd------%@",index,[NSThread currentThread]);
    });
    NSLog(@"apply------end");
}

/**
 
 组队列；dispatch_gorup
 
 */
//监听队列组
- (void)groupNotify{
    //打印当前线程
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    NSLog(@"group------begin");
    
    //创建一个组队列
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //添加任务一
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //添加任务二
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //添加任务三
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    //等待前面的异步任务执行完  回到主线程执行一下任务
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4------%@",[NSThread currentThread]);
        }
    });
}

//线程等待（暂停线程）dispatch_group_wait
- (void)groupWait{
    //打印当前线程
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    NSLog(@"group------begin");
    
    //创建一个组队列
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       //添加任务一
        for (int i = 0; i < 2; i++) {
            [NSThread currentThread];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       //追加任务二
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    
    //等待上面的任务全部完成后 往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"group------end");
}

//dispatch_group_enter、dispatch_group_leave
- (void)groupEnterAndLeave{
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    NSLog(@"group------begin");
    
    //创建一个组队列
    dispatch_group_t group = dispatch_group_create();
    //获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //进入组队列
    dispatch_group_enter(group);
    //追加任务一
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
        dispatch_group_leave(group);
    });
    
    //进入组队列
    dispatch_group_enter(group);
    //追加任务二
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
        dispatch_group_leave(group);
    });
    
    //等待前面的线程全部结束 回到主线程
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [NSThread sleepForTimeInterval:2];
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
        NSLog(@"group------end");
    });
}

//GCD信号量：dispatch_semaphore
- (void)semaphoreSync{
    NSLog(@"current------%@",[NSThread currentThread]);
    NSLog(@"semaphore------begin");
    
    //获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建一个 信号量总和 为 0的信号量 semaphore
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block int number = 0;
    //追加任务一
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
            number = 100;
            //发送给semaphore一个信号 让信号总量加一
        }
        dispatch_semaphore_signal(semaphore);

    });
    //等待上面的线程执行完以后 计数减一 执行下面的线程
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore------end,number = %d",number);
}

/**
线程安全和线程同步（为线程加锁）
*/
/**
 非线程安全（不使用semaphore）
 初始化火车票数量、卖票窗口（非线程安全）、并开始卖票
 */
- (void)initTicketStatusNotSafe{
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    NSLog(@"semaphore------begin");
    //初始化票总数
    self.ticketSurplusCount = 50;
    //队列一 北京火车票售卖窗口
    dispatch_queue_t queue1 = dispatch_queue_create("com.ceshi.tsou", DISPATCH_QUEUE_SERIAL);
    //队列二 上海火车票售卖窗口
    dispatch_queue_t queue2 = dispatch_queue_create("com.ceshi.tsou", DISPATCH_QUEUE_SERIAL);
    //转化为弱引用
    __weak typeof(self) weakSelf  = self;
    //异步执行任务 北京
    dispatch_async(queue1, ^{
        [weakSelf saleTicketNotSafe];
    });
    //上海
    dispatch_async(queue2, ^{
        [weakSelf saleTicketNotSafe];
    });
}
/**
 售卖火车票系统 算法实现
 */
- (void)saleTicketNotSafe{
    //恒为真
    while (1) {
        if (self.ticketSurplusCount > 0) {
            self.ticketSurplusCount --;
            NSLog(@"%@",[NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", self.ticketSurplusCount,[NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
            
        }else{
            //已经卖完 关闭售票窗口
            NSLog(@"所有车票已经售完");
            break;
        }
    }
}

/**
 线程安全（使用semaphore加锁）
 */
- (void)initTicketStatusSafe{
    NSLog(@"currentThread------%@",[NSThread currentThread]);
    NSLog(@"semaphore------begin");
    //初始化信号量为1
    semaphoreLock = dispatch_semaphore_create(1);
    //初始化余票总数
    self.ticketSurplusCount = 50;
    //初始化北京串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("com.ceshi.tsou", DISPATCH_QUEUE_SERIAL);
    //初始化上海队列
    dispatch_queue_t queue2 = dispatch_queue_create("com.ceshi.tsou", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue1, ^{
        [self saleTicketsafe];
    });
    
    dispatch_async(queue2, ^{
        [self saleTicketsafe];
    });
}
/**
 售卖火车票系统 加锁算法实现
 */
- (void)saleTicketsafe{
    //发送一个信号 阻塞下一个线程
    while (1) {
        //加锁
        dispatch_semaphore_wait(semaphoreLock, DISPATCH_TIME_FOREVER);

        if (self.ticketSurplusCount > 0) {
            self.ticketSurplusCount --;
            //打印余票以及窗口
            NSLog(@"%@",[NSString stringWithFormat:@"剩余票数：%ld 窗口：%@",self.ticketSurplusCount,[NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        }else{
            //票已售完 显示提示
            NSLog(@"票已售完");
            //发送信号 开放线程 相当于解锁
            dispatch_semaphore_signal(semaphoreLock);
            break;
        }
        //解锁
        dispatch_semaphore_signal(semaphoreLock);
    }
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [self chuanXing];//串行队列的创建
//    [self bingXing];//并发队列的创建
//    [self getMainQueue];//获取主队列
//    [self quanJuQueue];//获取全局队列
//    [self syncAndConcurrent];//同步执行 + 并发队列
//    [self asyncAndConcurrent];//异步执行 + 并发队列
//    [self syncAndSerial];//同步执行 + 串行队列
//    [self asyncAndSerial];//异步执行 + 串行队列
//    [self syncAndMain];//同步执行 + 主队列
//    [NSThread detachNewThreadSelector:@selector(syncAndMain) toTarget:self withObject:nil];//开辟新线程调用 同步任务 + 主队列 不会造成线程死锁 会放进主线程中执行
//    [self asyncAndMain];//异步执行 + 主队列
//    [self communication];
//    [self barrier];
//    [self after];
//    [self once];
//    [self apply];
//    [self groupNotify];
//    [self groupWait];
//    [self groupEnterAndLeave];
    [self semaphoreSync];
//    [self initTicketStatusNotSafe];
    [self initTicketStatusSafe];
    //线程跑完 测试
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, self.view.frame.size.width - 200, 100)];
    label.text = @"线程已结束";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
