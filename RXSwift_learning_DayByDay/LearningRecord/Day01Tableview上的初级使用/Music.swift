//
//  Music.swift
//  RXSwift_learning_DayByDay
//
//  Created by AlbertYuan on 2020/5/6.
//  Copyright © 2020 JoyReach. All rights reserved.
//

import UIKit

//
class Music: NSObject {
    let name: String //歌名
    let singer: String //演唱者

    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

//实现 CustomStringConvertible 协议，方便输出调试
extension Music {
    override var description: String {
        return "name：\(name) singer：\(singer)"
    }
}
