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
    let data = Observable.just([  //just
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
    ])
}
