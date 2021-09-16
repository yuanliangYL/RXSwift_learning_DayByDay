//
//  YLLabelFont.swift
//  RXSwift_learning_DayByDay
//
//  Created by AlbertYuan on 2020/5/7.
//  Copyright © 2020 JoyReach. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


//方式一：通过对 UI 类进行扩展
extension UILabel {

    public var fontSize: Binder<CGFloat> {

        return Binder(self) { (label, fontSize) in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }

        
    }
    
}



//方式二：通过对 Reactive 类进行扩展
/*
 既然使用了 RxSwift，那么更规范的写法应该是对 Reactive 进行扩展。这里同样是给 UILabel 增加了一个 fontSize 可绑定属性。
（注意：这种方式下，我们绑定属性时要写成 label.rx.fontSize）
 */
extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
