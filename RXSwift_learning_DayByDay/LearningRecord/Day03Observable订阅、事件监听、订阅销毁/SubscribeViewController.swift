//
//  SubscribeViewController.swift
//  RXSwift_learning_DayByDay
//
//  Created by AlbertYuan on 2020/5/7.
//  Copyright © 2020 JoyReach. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SubscribeViewController: UIViewController {

    let info: String = "使用 subscribe() 订阅了一个Observable 对象，该方法的 block 的回调参数就是被发出的 event 事件\n 初始化 Observable 序列时设置的默认值都按顺序通过 .next 事件发送出来。\n 当 Observable 序列的初始数据都发送完毕，它还会自动发一个 .completed 事件出来。\n如果想要获取到这个事件里的数据，可以通过 event.element 得到。"

    //除了 dispose()方法之外，我们更经常用到的是一个叫 DisposeBag 的对象来管理多个订阅行为的销毁： 我们可以把一个 DisposeBag对象看成一个垃圾袋，把用过的订阅行为都放进去。 而这个DisposeBag 就会在自己快要dealloc 的时候，对它里面的所有订阅行为都调用 dispose()方法。
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        //typeOne()

        //typeTwo()

        //doonlifeCycle()

        //observableToDisposed

        intervarDispose()
    }

    deinit {
        print("deinit this VC :释放了")
    }

        func typeOne() -> () {
            /*
             使用 subscribe() 订阅了一个Observable 对象，该方法的 block 的回调参数就是被发出的 event 事件
             初始化 Observable 序列时设置的默认值都按顺序通过 .next 事件发送出来。
             当 Observable 序列的初始数据都发送完毕，它还会自动发一个 .completed 事件出来。
             */
            let observable = Observable.of("A", "B", "C")

            observable.subscribe { event in
                print(event)

                //如果想要获取到这个事件里的数据，可以通过 event.element 得到。
                print(event.element as Any)
            }.disposed(by: disposeBag)
        }

        func typeTwo() -> () {
            let observable = Observable.of("A", "B", "C")

            /*
             通过不同的 block 回调处理不同类型的 event。（其中 onDisposed 表示订阅行为被 dispose 后的回调;
             同时会把 event 携带的数据直接解包出来作为参数，方便我们使用。
             subscribe() 方法的 onNext、onError、onCompleted 和 onDisposed 这四个回调 block 参数都是有默认值的，即它们都是可选的。所以我们也可以只处理 onNext而不管其他的情况。
             observable.subscribe(onNext: { element in
             print(element)
             })

             */
            observable.subscribe(onNext: { element in
                print(element)
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")//dispose 处理；处置；安排
            }).disposed(by: disposeBag)
        }

        /*
         我们可以使用                     doOn 方法来监听事件的生命周期，             它会在每一次事件发送前被调用。
         同时它和 subscribe 一样，可以通过不同的block 回调处理不同类型的 event。
         do(onNext:)方法就是在subscribe(onNext:) 前调用
         而 do(onCompleted:) 方法则会在 subscribe(onCompleted:) 前面调用。
         */
        func doonlifeCycle() -> () {
            let observable = Observable.of("A", "B", "C")

            observable
                .do(onNext: { element in
                    print("Intercepted Next：", element)
                }, onError: { error in
                    print("Intercepted Error：", error)
                }, onCompleted: {
                    print("Intercepted Completed")
                }, onDispose: {
                    print("Intercepted Disposed")
                })
                .subscribe(onNext: { element in
                    print(element)
                }, onError: { error in
                    print(error)
                }, onCompleted: {
                    print("completed")
                }, onDisposed: {
                    print("disposed")
                }).disposed(by: disposeBag)
        }


        /*
         1，Observable 从创建到终结流程
         （1）一个 Observable 序列被创建出来后它不会马上就开始被激活从而发出 Event，而是要等到它被某个人订阅了才会激活它。
         （2）而 Observable 序列激活之后要一直等到它发出了.error或者 .completed的 event 后，它才被终结。

         2，dispose() 方法
         （1）使用该方法我们可以手动取消一个订阅行为。
         （2）如果我们觉得这个订阅结束了不再需要了，就可以调用 dispose()方法把这个订阅给销毁掉，防止内存泄漏。
         （3）当一个订阅行为被dispose 了，那么之后 observable 如果再发出 event，这个已经 dispose 的订阅就收不到消息了。
         */
        func observableToDisposed() -> Void {
            let observable = Observable.of("A", "B", "C")

            //使用subscription常量存储这个订阅方法
            observable.subscribe { event in
                print(event)
            }.disposed(by: disposeBag)

            //第2个Observable，及其订阅
            let observable2 = Observable.of(1, 2, 3)
            observable2.subscribe { event in
                print(event)
            }.disposed(by: disposeBag)
        }


        /*
            除了 dispose()方法之外，我们更经常用到的是一个叫 DisposeBag 的对象来管理多个订阅行为的销毁：
            我们可以把一个 DisposeBag对象看成一个垃圾袋，把用过的订阅行为都放进去。
            而这个DisposeBag 就会在自己快要dealloc 的时候，对它里面的所有订阅行为都调用 dispose()方法。
        */
        func intervarDispose() -> () {

            let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)

            let subscribetion = observable.subscribe(onNext: { (event) in
                print(event)
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("Completed")
            }, onDisposed: {
                print("Disposed")
            })

            //15秒后回收，也可根据具体业务需求在适当的时候加上这句话
            let deadline = DispatchTime.now() + 15

            DispatchQueue.main.asyncAfter(deadline: deadline) {
                subscribetion.disposed(by: DisposeBag())
            }

        }


        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

            SwiftMessageManager.showMessage(layoutType: .CardView, themeType:.Success, iconImageType:.light, presentationStyleType:.top, title: "详情", body:info, isHiddenBtn: true, seconds: 6)
        }


}
