//
//  ObservableViewModel.swift
//  RXSwift_learning_DayByDay
//
//  Created by AlbertYuan on 2020/5/7.
//  Copyright © 2020 JoyReach. All rights reserved.
//

import Foundation
import RxSwift

enum MyError: Error {
    case A
    case B
}

//13种创建序列的方法
struct ObservableViewModel {

    //显式地标注出了 observable 的类型为 Observable<Array>，即指定了这个 Observable所发出的事件携带的数据类型必须是 Array 类型的。
    let data = Observable<Array>.just([

        ObservablemethodModel(name: "just() 方法", detail: "该方法通过传入一个默认值来初始化可观察序列;let observable = Observable<Int>.just(5)"),

        ObservablemethodModel(name: "of() 方法", detail: "该方法可以接受可变数量的参数（必需要是同类型的）;let observable = Observable.of(\"A\", \"B\", \"C\")"),

        ObservablemethodModel(name: "from() 方法", detail: "该方法需要一个数组参数;let observable = Observable.from([\"A\", \"B\",\"C\"])，示例中数据里的元素就会被当做这个 Observable 所发出 event携带的数据内容，最终效果同上面饿 of()样例是一样的"),

        ObservablemethodModel(name: "empty() 方法", detail: "该方法创建一个空内容的 Observable 序列;let observable = Observable<Int>.empty()"),

        ObservablemethodModel(name: "never() 方法", detail: "该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列;let observable = Observable<Int>.never()"),

        ObservablemethodModel(name: "error() 方法", detail: "该方法创建一个不做任何操作，而是直接发送一个错误的 Observable 序列;let observable = Observable<Int>.error(MyError.A)"),

        ObservablemethodModel(name: "range() 方法", detail: "该方法通过指定起始和结束数值，创建一个以这个范围内所有值作为初始值的Observable序列。//使用range() let observable = Observable.range(start: 1, count: 5) == //使用of() let observable = Observable.of(1, 2, 3 ,4 ,5)"),

        ObservablemethodModel(name: "repeatElement() 方法", detail: "该方法创建一个可以无限发出给定元素的 Event的 Observable 序列（永不终止）;let observable = Observable.repeatElement(1)"),

        ObservablemethodModel(name: "generate() 方法", detail: "该方法创建一个只有当提供的所有的判断条件都为 true 的时候，才会给出动作的 Observable 序列。//使用generate()方法 let observable = Observable.generate( initialState: 0, condition: { $0 <= 10 }, iterate: { $0 + 2 } )"),

        //创建序列最直接的方法就是调用 Observable.create，然后在构建函数里面描述元素的产生过程
        ObservablemethodModel(name: "create() 方法✨", detail: "该方法接受一个 block 形式的参数，任务是对每一个过来的订阅进行处理"),

        ObservablemethodModel(name: "deferred() 方法（ 推迟、延期的）", detail: "该个方法相当于是创建一个 Observable 工厂，通过传入一个 block 来执行延迟 Observable序列创建的行为，而这个 block 里就是真正的实例化序列对象的地方。"),

        ObservablemethodModel(name: "interval() 方法", detail: "这个方法创建的 Observable 序列每隔一段设定的时间，会发出一个索引数的元素(从0开始)。而且它会一直发送下去。"),

        ObservablemethodModel(name: "timer() 方法", detail: "这个方法有两种用法，一种是创建的 Observable序列在经过设定的一段时间后，产生唯一的一个元素。；另一种是创建的 Observable 序列在经过设定的一段时间后，每隔一段时间产生一个元素。"),
    ])
    
}

//决策树可以帮助你找到需要的操作符
/*
 我想要创建一个 Observable

 产生特定的一个元素：just
 经过一段延时：timer
 从一个序列拉取元素：from
 重复的产生某一个元素：repeatElement
 存在自定义逻辑：create
 每次订阅时产生：deferred
 每隔一段时间，发出一个元素：interval
 在一段延时后：timer
 一个空序列，只有一个完成事件：empty
 一个任何事件都没有产生的序列：never


 我想要创建一个 Observable 通过组合其他的 Observables
 任意一个 Observable 产生了元素，就发出这个元素：merge
 让这些 Observables 一个接一个的发出元素，当上一个 Observable 元素发送完毕后，下一个 Observable 才能开始发出元素：concat
 组合多个 Observables 的元素
 当每一个 Observable 都发出一个新的元素：zip
 当任意一个 Observable 发出一个新的元素：combineLatest
 我想要转换 Observable 的元素后，再将它们发出来

 对每个元素直接转换：map
 转换到另一个 Observable：flatMap
 只接收最新的元素转换的 Observable 所产生的元素：flatMapLatest
 每一个元素转换的 Observable 按顺序产生元素：concatMap
 基于所有遍历过的元素： scan
 我想要将产生的每一个元素，拖延一段时间后再发出：delay

 我想要将产生的事件封装成元素发送出来
 将他们封装成 Event<Element>：materialize
 然后解封出来：dematerialize
 我想要忽略掉所有的 next 事件，只接收 completed 和 error 事件：ignoreElements

 我想创建一个新的 Observable 在原有的序列前面加入一些元素：startWith
 我想从 Observable 中收集元素，缓存这些元素之后在发出：buffer
 我想将 Observable 拆分成多个 Observables：window
 基于元素的共同特征：groupBy
 我想只接收 Observable 中特定的元素

 发出唯一的元素：single
 我想重新从 Observable 中发出某些元素

 通过判定条件过滤出一些元素：filter
 仅仅发出头几个元素：take
 仅仅发出尾部的几个元素：takeLast
 仅仅发出第 n 个元素：elementAt
 跳过头几个元素
 跳过头 n 个元素：skip
 跳过头几个满足判定的元素：skipWhile，skipWhileWithIndex
 跳过某段时间内产生的头几个元素：skip
 跳过头几个元素直到另一个 Observable 发出一个元素：skipUntil
 只取头几个元素
 只取头几个满足判定的元素：takeWhile，takeWhileWithIndex
 只取某段时间内产生的头几个元素：take
 只取头几个元素直到另一个 Observable 发出一个元素：takeUntil
 周期性的对 Observable 抽样：sample
 发出那些元素，这些元素产生后的特定的时间内，没有新的元素产生：debounce
 直到元素的值发生变化，才发出新的元素：distinctUntilChanged
 并提供元素是否相等的判定函数：distinctUntilChanged
 在开始发出元素时，延时后进行订阅：delaySubscription
 我想要从一些 Observables 中，只取第一个产生元素的 Observable：amb

 我想评估 Observable 的全部元素

 并且对每个元素应用聚合方法，待所有元素都应用聚合方法后，发出结果：reduce
 并且对每个元素应用聚合方法，每次应用聚合方法后，发出结果：scan
 我想把 Observable 转换为其他的数据结构：as...

 我想在某个 Scheduler 应用操作符：subscribeOn

 在某个 Scheduler 监听：observeOn
 我想要 Observable 发生某个事件时, 采取某个行动：do

 我想要 Observable 发出一个 error 事件：error

 如果规定时间内没有产生元素：timeout
 我想要 Observable 发生错误时，优雅的恢复

 如果规定时间内没有产生元素，就切换到备选 Observable ：timeout
 如果产生错误，将错误替换成某个元素 ：catchErrorJustReturn
 如果产生错误，就切换到备选 Observable ：catchError
 如果产生错误，就重试 ：retry
 我创建一个 Disposable 资源，使它与 Observable 具有相同的寿命：using

 我创建一个 Observable，直到我通知它可以产生元素后，才能产生元素：publish

 并且，就算是在产生元素后订阅，也要发出全部元素：replay
 并且，一旦所有观察者取消观察，他就被释放掉：refCount
 通知它可以产生元素了：connect
 */
