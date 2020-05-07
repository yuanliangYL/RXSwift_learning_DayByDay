//
//  SwiftMessageManager.swift
//  RXSwift_learning_DayByDay
//
//  Created by AlbertYuan on 2020/5/7.
//  Copyright © 2020 JoyReach. All rights reserved.
//

import UIKit
import SwiftMessages

//布局样式
enum  LayoutType : String{

    case MessageView

    case CardView

    case TabView

    case StatusLine

    case MessageViewIOS8
}

//消息类型
public enum ThemeType : String {
    case Info

    case Success

    case Warning

    case Error
}

class SwiftMessageManager: NSObject {

    /**
     生产 status 的抽取方法

     - parameter layoutType:            布局样式
     - parameter themeType:             消息类型
     - parameter iconImageType:         消息图标的类型
     - parameter presentationStyleType: 模态的位置
     - parameter title:                 标题
     - parameter body:                  说明文字
     - parameter isHiddenBtn:           是否 隐藏 按钮
     - parameter seconds:               显示的时间
     */

    class func showMessage(layoutType:LayoutType, themeType :ThemeType ,iconImageType : IconStyle, presentationStyleType :SwiftMessages.PresentationStyle, title :String,body:String, isHiddenBtn: Bool,seconds :TimeInterval) {

        var view = MessageView.viewFromNib(layout: .messageView)

        switch layoutType {

        case .MessageView:
//            print("已经在初始化的时候执行过")
            break
        case .CardView:
            view = MessageView.viewFromNib(layout: .cardView)
             break
        case .TabView:
            view = MessageView.viewFromNib(layout: .tabView)
             break
        case .StatusLine:
            view = MessageView.viewFromNib(layout: .statusLine)
             break
        default:
            break
        }


        view.configureContent(title: title, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "确认", buttonTapHandler: { _ in SwiftMessages.hide() })

        switch themeType {

        case .Success:

            view.configureTheme(.success, iconStyle:iconImageType)

        case .Warning:
            view.configureTheme(.warning, iconStyle:iconImageType)

        case .Error:
            view.configureTheme(.error, iconStyle:iconImageType)

        default:
            view.configureTheme(.info, iconStyle:iconImageType)

        }

        view.button?.isHidden = isHiddenBtn;

        var infoConfig = SwiftMessages.Config()
        infoConfig.presentationStyle = presentationStyleType
        infoConfig.duration = .seconds(seconds: seconds)

        SwiftMessages.show(config: infoConfig, view: view)
    }
}
