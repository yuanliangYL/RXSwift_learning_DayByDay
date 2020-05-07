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
    var controllerArr: [UIViewController] = []


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
            "Day01:响应式编程与传统式编程的比较",
            "Day02:Observable介绍、创建可观察序列"
        ];
        tableView.reloadData()


        controllerArr = [
            MusicController(),
            ObservableViewController()
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
        navigationController?.pushViewController(controllerArr[indexPath.row], animated: true)
    }

}
