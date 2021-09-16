//
//  ObserverViewController.swift
//  RXSwift_learning_DayByDay
//
//  Created by AlbertYuan on 2020/5/7.
//  Copyright © 2020 JoyReach. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ObserverViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    let disposedBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()


//        subscripmethod()

//        bindmethod()

//        anyObserverToCreat()

        useBinder()

    }


    //在 subscribe 方法中创建
    func subscripmethod() -> () {
        /*
                （1）创建观察者最直接的方法就是在 Observable 的 subscribe 方法后面描述当事件发生时，需要如何做出响应。
                （2）比如下面的样例，观察者就是由后面的 onNext，onError，onCompleted 这些闭包构建出来的。
               */
               let observable = Observable.of("A", "B", "C")
               observable.subscribe(onNext: { element in
                   print(element)
               }, onError: { error in
                   print(error)
               }, onCompleted: {
                   print("completed")
               }).disposed(by: disposedBag)
    }


    //在 bind 方法中创建
    func bindmethod() -> () {
        //在 bind 方法中创建   （1）下面代码我们创建一个定时生成索引数的 Observable 序列，并将索引数不断显示在 label 标签上：
        //Observable序列（每隔1秒钟发出一个索引数）
        let observablelabel = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observablelabel
            .map { "当前索引数：\($0 )"} //map的作用？
            .bind { [weak self] (text) in  //闭包中的弱引用操作[weak self]
                //收到发出的索引数后显示到label上
                self?.label.text = text
        }
        .disposed(by: disposedBag)
    }



    //使用 AnyObserver 创建观察者:AnyObserver 可以用来描叙任意一种观察者。
    func anyObserverToCreat() -> () {
     //        1，配合 subscribe 方法使用
        //观察者
        let observer: AnyObserver<Int> = AnyObserver { (event) in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
//        let observable = Observable.of("A", "B", "C")
//        observable.subscribe(observer).disposed(by: disposedBag)

         let observable = Observable.of(11, 22, 33)
         observable.subscribe(observer).disposed(by: disposedBag)



        //配合 bindTo 方法使用
        //观察者
        let observerb: AnyObserver<String> = AnyObserver { [weak self] (event) in
            switch event {
            case .next(let text):
                //收到发出的索引数后显示到label上
                self?.label.text = text
            default:
                break
            }
        }

        //Observable序列（每隔1秒钟发出一个索引数）
        let observableb = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observableb
            .map { "当前索引数：\($0 )"}
            .bind(to: observerb)
            .disposed(by: disposedBag)
    }


    //使用 Binder 创建观察者
    /*
    （1）相较于AnyObserver 的大而全，Binder 更专注于特定的场景。Binder 主要有以下两个特征：
     不会处理错误事件
     确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
    （2）一旦产生错误事件，在调试环境下将执行 fatalError，在发布环境下将打印错误信息。
     */
    func useBinder() -> Void {

        //观察者
        let observer: Binder<String> = Binder(label) { (lab, text) in
            //收到发出的索引数后显示到label上
            lab.text = text
        }

        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "当前索引数：\($0 )"}
            .bind(to: observer)
            .disposed(by: disposedBag)
    }

    deinit {
        print("deinit")
    }


    /*

     观察者（Observer）的     作用就是监听响应事件。    或者说        任何响应事件的行为都是观察者。

     当我们点击按钮，弹出一个提示框。那么这个“弹出一个提示框”就是观察者Observer<Void>
     当我们请求一个远程的json 数据后，将其打印出来。那么这个“打印 json 数据”就是观察者 Observer<JSON>


    */

}
