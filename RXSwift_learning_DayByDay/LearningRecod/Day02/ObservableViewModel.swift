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

struct ObservableViewModel {

    let data = Observable<Array>.just([  //显式地标注出了 observable 的类型为 Observable<Array>，即指定了这个 Observable所发出的事件携带的数据类型必须是 Array 类型的。
        ObservablemethodModel(name: "just() 方法", detail: "该方法通过传入一个默认值来初始化;let observable = Observable<Int>.just(5)"),
        ObservablemethodModel(name: "of() 方法", detail: "该方法可以接受可变数量的参数（必需要是同类型的）;let observable = Observable.of(\"A\", \"B\", \"C\")"),
        ObservablemethodModel(name: "from() 方法", detail: "该方法需要一个数组参数;let observable = Observable.from([\"A\", \"B\",\"C\"])例中数据里的元素就会被当做这个 Observable 所发出 event携带的数据内容，最终效果同上面饿 of()样例是一样的"),
        ObservablemethodModel(name: "empty() 方法", detail: "该方法创建一个空内容的 Observable 序列;let observable = Observable<Int>.empty()"),
        ObservablemethodModel(name: "never() 方法", detail: "该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列;let observable = Observable<Int>.never()"),
        ObservablemethodModel(name: "error() 方法", detail: "该方法创建一个不做任何操作，而是直接发送一个错误的 Observable 序列;let observable = Observable<Int>.error(MyError.A)"),
        ObservablemethodModel(name: "range() 方法", detail: "该方法通过指定起始和结束数值，创建一个以这个范围内所有值作为初始值的Observable序列。//使用range() let observable = Observable.range(start: 1, count: 5) == //使用of() let observable = Observable.of(1, 2, 3 ,4 ,5)"),
        ObservablemethodModel(name: "repeatElement() 方法", detail: "该方法创建一个可以无限发出给定元素的 Event的 Observable 序列（永不终止）;let observable = Observable.repeatElement(1)"),
        ObservablemethodModel(name: "generate() 方法", detail: "该方法创建一个只有当提供的所有的判断条件都为 true 的时候，才会给出动作的 Observable 序列。//使用generate()方法 let observable = Observable.generate( initialState: 0, condition: { $0 <= 10 }, iterate: { $0 + 2 } )"),
        ObservablemethodModel(name: "create() 方法✨", detail: "该方法接受一个 block 形式的参数，任务是对每一个过来的订阅进行处理。"),
        ObservablemethodModel(name: "deferred() 方法（ 推迟、延期的）", detail: "该个方法相当于是创建一个 Observable 工厂，通过传入一个 block 来执行延迟 Observable序列创建的行为，而这个 block 里就是真正的实例化序列对象的地方。"),
        ObservablemethodModel(name: "interval() 方法", detail: "这个方法创建的 Observable 序列每隔一段设定的时间，会发出一个索引数的元素。而且它会一直发送下去。"),
        ObservablemethodModel(name: "timer() 方法", detail: "这个方法有两种用法，一种是创建的 Observable序列在经过设定的一段时间后，产生唯一的一个元素。；另一种是创建的 Observable 序列在经过设定的一段时间后，每隔一段时间产生一个元素。"),
    ])
    
}
