//
//  ObservableViewController.swift
//  RXSwift_learning_DayByDay
//
//  Created by AlbertYuan on 2020/5/7.
//  Copyright © 2020 JoyReach. All rights reserved.
//
/*

 可观察序列:Observable
 Event:事件
 订阅者:Observer


 Observable<T> 这个类就是Rx 框架的基础，我们可以称它为可观察序列。
 它的作用就是可以异步地产生一系列的 Event（事件）, Event 就是一个枚举:
 有了可观察序列，我们还需要有一个Observer（订阅者）来订阅它，这样这个订阅者才能收到 Observable<T> 不时发出的 Event。
 */


import UIKit

import RxSwift

import RxCocoa
import SwiftMessages

class ObservableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let observableViewModel = ObservableViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "obsevableCell")

        //将数据源数据绑定到tableView上
        observableViewModel.data
            .bind(to: tableView.rx.items(cellIdentifier:"obsevableCell")) { _, obsevablemodel, cell in
                cell.textLabel?.text = obsevablemodel.name
        }.disposed(by: disposeBag)
        
        //tableView点击响应
        tableView.rx.modelSelected(ObservablemethodModel.self)
            .subscribe(onNext: {obsevablemodel in

                SwiftMessageManager.showMessage(layoutType: .MessageView,
                                                themeType:.Success,
                                                iconImageType:.light,
                                                presentationStyleType:.top,
                                                title: "详情",
                                                body: obsevablemodel.detailinfo,
                                                isHiddenBtn: true,
                                                seconds: 6)

            })
            .disposed(by: disposeBag)


        tableView.rx.itemSelected
            .subscribe(onNext :{ IndexPath in
                switch IndexPath.row {
                
                case 8: //generate() 方法

                    let observable = Observable.generate(
                        initialState: 0,
                        condition: { $0 <= 10 },
                        iterate: { $0 + 2 }
                    )
                    let _ = observable.subscribe {
                        print($0)
                    }

                case 9: //create() 方法

                    //这个block有一个回调参数observer就是订阅这个Observable对象的订阅者
                    //当一个订阅者订阅这个Observable对象的时候，就会将订阅者作为参数传入这个block来执行一些内容
                    let observable = Observable<String>.create{observer in
                        //对订阅者发出了.next事件，且携带了一个数据"hangge.com"
                        observer.onNext("hangge.com")
                        //对订阅者发出了.completed事件
                        observer.onCompleted()
                        //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
                        return Disposables.create()
                    }
                    //订阅测试
                    let _ =  observable.subscribe {
                        print($0)
                    }



                case 10: //deferred() 方法

                    //用于标记是奇数、还是偶数
                    var isOdd = true

                    //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
                    let factory : Observable<Int> = Observable.deferred {
                        //让每次执行这个block时候都会让奇、偶数进行交替
                        isOdd = !isOdd

                        //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
                        if isOdd {
                            return Observable.of(1, 3, 5 ,7)
                        }else {
                            return Observable.of(2, 4, 6, 8)
                        }
                    }

                    //第1次订阅测试
                    let _ =  factory.subscribe { event in
                        print("\(isOdd)", event)
                    }

                    //第2次订阅测试
                    let _ =  factory.subscribe { event in
                        print("\(isOdd)", event)
                    }


                case 11:
                    //interval() 方法
                    let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
                    let _ = observable.subscribe { event in
                        print(event)
                    }
                    .disposed(by: self.disposeBag)

                case 12:
                    //timer() 方法 //这个方法有两种用法
                    //5秒种后发出唯一的一个元素0
//                    let observable = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
//                    let _ = observable.subscribe { event in
//                        print(event)
//                    }.disposed(by: self.disposeBag)


                     //延时5秒种后，每隔1秒钟发出一个元素
                     let observable = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
                     observable.subscribe { event in
                     print(event)
                     }.disposed(by: self.disposeBag)
                    //period：n. 周期，期间；时期；一段时间；经期；课时；句点，句号

                default:
                    break
                }
            }).disposed(by: disposeBag)

        //设置 tableView Delegate/DataSource 的代理方法
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }



}

// MARK: - protocol UITableViewDelegate

extension ObservableViewController: UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


