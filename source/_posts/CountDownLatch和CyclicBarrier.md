---
title: CountDownLatch和CyclicBarrier
date: 2017-08-28 18:28:22
tags: [Java]
---
## 场景一
工作中需要在web服务对外之前，spring的bean初始化的时候加载数据到缓存中。  
但是由于数据量过大，需要多线程加载。要求所有的缓存加载成功之后，这个bean才初始化成功，程序继续往下走。  
## 场景二
商务合作的需求，需要显示的数据来自合作方和我们自己的数据库中。  
之前是只显示我们数据库点数据，现在合作方提供了一个接口让我实时调用对方的接口，并把两部分的数据合并后返回给前端。  
但是由于合作方的接口不是特别稳定，而且也不能保证高可用，所以可以考虑同时从我们和合作方取数据，设置超时时间，如果都返回了数据就合并给前端，如果对方未能返回数据，还是有我们自己的数据能显示给用户的。  

# CountDownLatch和CyclicBarrier
综合上述两个场景，我看了CountDownLatch和CyclicBarrier，看说明觉得比较适合我的使用。  

## CountDownLatch

```
package countdownlatchtest;

import com.google.common.collect.Maps;

import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.CountDownLatch;

public class CountDownLatchService {

    private CountDownLatch countDownLatch = new CountDownLatch(4);

    /**
     * 用来存储所有线程的运行结果
     */
    private ConcurrentMap<String, String> resultMap = Maps.newConcurrentMap();



    public CountDownLatch getCountDownLatch() {
        return countDownLatch;
    }

    public ConcurrentMap<String, String> getResultMap() {
        return resultMap;
    }
}
```
  
```
package countdownlatchtest;

import org.apache.commons.lang3.RandomUtils;

import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.CountDownLatch;

public class Worker implements Runnable {

    private ConcurrentMap<String, String> map;
    private CountDownLatch countDownLatch;

    public Worker(ConcurrentMap<String, String> map, CountDownLatch countDownLatch) {
        this.map = map;
        this.countDownLatch = countDownLatch;
    }

    @Override
    public void run() {

        // 这里写代码做某些事
        System.out.println(Thread.currentThread().getName() + "\t开始了...");
        final int sleep = RandomUtils.nextInt(5, 20);
        try {
            Thread.sleep(sleep * 1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        // 添加结果到map中
        map.putIfAbsent(Thread.currentThread().getName(), String.valueOf(sleep));

        // 告诉 countDownLatch ，当前线程完成了
        System.out.println(Thread.currentThread().getName() + "\t结束了...");
        countDownLatch.countDown();
    }
}

```
  
```
package countdownlatchtest;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {

    public static void main(String[] args) {
        final ExecutorService executorService = Executors.newFixedThreadPool(6);
        for (int i = 0; i < 3; i++) {
            // 模拟多次执行任务
            doTask(executorService);
        }
    }

    private static void doTask(ExecutorService executorService) {
        CountDownLatchService countDownLatchService = new CountDownLatchService();
        for (int i = 0; i < 4; i++) {
            Worker worker = new Worker(countDownLatchService.getResultMap(), countDownLatchService.getCountDownLatch());
            executorService.submit(worker);
        }
        try {
            // 阻塞在这里，等待其他线程执行完成
            countDownLatchService.getCountDownLatch().await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("所有线程执行成功");
        System.out.println("打印结果如下：\n" + countDownLatchService.getResultMap());
    }

}
```

## CyclicBarrier
```
package cyclicbarriertest;

import com.google.common.collect.Maps;

import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.CyclicBarrier;

public class CyclicBarrierService implements Runnable {

    /**
     * 表示当有4个线程执行完的时候，会调用第二个参数 barrierAction 的start()方法
     *
     * 所以本类实现 Runnable 接口，传入this
     */
    private CyclicBarrier cyclicBarrier = new CyclicBarrier(4, this);

    /**
     * 用来存储所有线程的运行结果
     */
    private ConcurrentMap<String, String> resultMap = Maps.newConcurrentMap();

    @Override
    public void run() {
        System.out.println("所有线程执行成功");
        System.out.println("打印结果如下：\n" + resultMap);
    }

    public ConcurrentMap<String, String> getResultMap() {
        return resultMap;
    }

    public CyclicBarrier getCyclicBarrier() {
        return cyclicBarrier;
    }
}
```
```
package cyclicbarriertest;

import org.apache.commons.lang3.RandomUtils;

import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.CyclicBarrier;

public class Worker implements Runnable {

    private ConcurrentMap<String, String> map;
    private CyclicBarrier cyclicBarrier;

    public Worker(ConcurrentMap<String, String> map, CyclicBarrier cyclicBarrier) {
        this.map = map;
        this.cyclicBarrier = cyclicBarrier;
    }

    @Override
    public void run() {

        // 这里写代码做某些事
        System.out.println(Thread.currentThread().getName() + "\t开始了...");
        final int sleep = RandomUtils.nextInt(5, 20);
        try {
            Thread.sleep(sleep * 1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        // 添加结果到map中
        map.putIfAbsent(Thread.currentThread().getName(), String.valueOf(sleep));

        try {
            // 告诉 cyclicBarrier ，当前线程完成了
            System.out.println(Thread.currentThread().getName() + "\t结束了...");
            cyclicBarrier.await();
        } catch (InterruptedException | BrokenBarrierException e) {
            e.printStackTrace();
        }
    }
}
```

```
package cyclicbarriertest;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {

    public static void main(String[] args) {
        final ExecutorService executorService = Executors.newFixedThreadPool(6);
        for (int j = 0; j < 3; j++) {
            // 模拟多次任务执行
            doTask(executorService);
        }
    }

    private static void doTask(ExecutorService executorService) {
        CyclicBarrierService cyclicBarrierService = new CyclicBarrierService();
        for (int i = 0; i < 4; i++) {
            Worker worker = new Worker(cyclicBarrierService.getResultMap(), cyclicBarrierService.getCyclicBarrier());
            executorService.submit(worker);
        }
    }
}

```

## 总结
写了上面两个例子，后面发现场景一适合用`CountDownLatch`，场景二适合用`CyclicBarrier`。场景一我们基本上不存在有任务不能执行完的情况，基本上做到计数器不归0，即使服务启动了也没办法正常使用，场景二很多情况都是任务不能正常的执行完成。  


