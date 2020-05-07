//
//  ViewController.swift
//  RXSwift_learning_DayByDay
//
//  Created by AlbertYuan on 2020/5/6.
//  Copyright © 2020 JoyReach. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    private let reuseCell = "reuseCell"

    //数据模型
    var dataArr: [String] = []
    var controllerArr: [String] = []


    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        initData()

    }

    func setupUI(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseCell)
    }

    func initData() -> () {
        dataArr = [
            "响应式编程与传统式编程的比较",
            "Observable介绍、创建可观察序列",
            "Observable订阅、事件监听、订阅销毁",
            "观察者1： AnyObserver、Binder",
            "观察者2： 自定义可绑定属性"
        ];
        tableView.reloadData()

        controllerArr = [
            "MusicController",
            "ObservableViewController",
            "SubscribeViewController",
            "ObserverViewController",
            "CustomBinderVC"
        ]
    }

}


// MARK: --  UITableView

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier:reuseCell , for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row]
        cell.selectionStyle = .none
        return cell;

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //1:动态获取命名空间
        guard  let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("获取命名空间失败")
            return
        }
        //根据命名空间和传过来的控制器名字获取控制器的类
        let vcClass: AnyClass? = Bundle.main.classNamed("\(nameSpace).\(controllerArr[indexPath.row])")

         // Swift中如果想通过一个Class来创建一个对象, 必须告诉系统这个Class的确切类型
        guard let typeClass = vcClass as? UIViewController.Type else {
             print("vcClass不能当做UIViewController")
             return
         }
        let myVc = typeClass.init()

        navigationController?.pushViewController(myVc, animated: true)

    }

}
