//
//  MusicListViewModel.swift
//  RXSwift_learning_DayByDay
//
//  Created by AlbertYuan on 2020/5/6.
//  Copyright © 2020 JoyReach. All rights reserved.
//

import Foundation
import RxSwift

//歌曲列表数据源  //传统方式
//struct MusicListViewModel {
//    let data = [
//        Music(name: "无条件", singer: "陈奕迅"),
//        Music(name: "你曾是少年", singer: "S.H.E"),
//        Music(name: "从前的我", singer: "陈洁仪"),
//        Music(name: "在木星", singer: "朴树"),
//    ]
//}


// RxSwift 进行改造
struct MusicListViewModel {

    //just 该方法通过传入一个默认值来初始化一个可观察序列：let observable = Observable<Int>.just(5)
    let data = Observable.just(
        [
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        ]
    )
}
