//
//  CustomBinderVC.swift
//  RXSwift_learning_DayByDay
//
//  Created by AlbertYuan on 2020/5/7.
//  Copyright © 2020 JoyReach. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CustomBinderVC: UIViewController {

    @IBOutlet weak var label: UILabel!

    let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()

        //        withUIKit()

        //        withReactiveKit()

        rxswiftUIobservable()

    }


    //    通过对 UI 类进行扩展
    func withUIKit() -> () {
        //Observable序列（每隔0.5秒钟发出一个索引数）
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)//主线程监听
        observable
            .map { CGFloat($0) }
            .bind(to: label.fontSize) //根据索引数不断变放大字体
            .disposed(by: disposeBag)

    }


    //    通过对 Reactive 类进行扩展
    func withReactiveKit() -> () {
        //Observable序列（每隔0.5秒钟发出一个索引数）
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable
            .map { CGFloat($0) }
            .bind(to: label.rx.fontSize) //根据索引数不断变放大字体
            .disposed(by: disposeBag)
    }

    //  RxSwift 自带的可绑定属性（UI 观察者）
    func rxswiftUIobservable() -> () {
        //其实 RxSwift 已经为我们提供许多常用的可绑定属性。比如 UILabel 就有 text 和 attributedText 这两个可绑定属性。
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "当前索引数：\($0 )"}
            .bind(to: label.rx.text) //收到发出的索引数后显示到label上
            .disposed(by: disposeBag)
    }

    
}
