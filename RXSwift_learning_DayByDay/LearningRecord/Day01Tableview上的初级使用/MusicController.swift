//
//  MusicController.swift
//  RXSwift_learning_DayByDay
//
//  Created by AlbertYuan on 2020/5/6.
//  Copyright © 2020 JoyReach. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa //对Cocoa框架的Rx封装

//传统方式
//class MusicController: UIViewController {
//
//    //tableView对象
//    @IBOutlet weak var tableView: UITableView!
//
//    //歌曲列表数据源
//    let musicListViewModel = MusicListViewModel()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//         //设置代理
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")
//    }
//
//}
//extension MusicController: UITableViewDataSource {
//    //返回单元格数量
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return musicListViewModel.data.count
//    }
//
//    //返回对应的单元格
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
//        -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell")!
//        let music = musicListViewModel.data[indexPath.row]
//        cell.textLabel?.text = music.name
//        cell.detailTextLabel?.text = music.singer
//        return cell
//    }
//}
//extension MusicController: UITableViewDelegate {
//    //单元格点击
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("你选中的歌曲信息【\(musicListViewModel.data[indexPath.row])】")
//    }
//}


// MARK: RxSwift 进行改造 这里我们不再需要实现数据源和委托协议了。而是写一些响应式代码，让它们将数据和 UITableView 建立绑定关系
class MusicController: UIViewController {

    @IBOutlet weak var mytableView: UITableView!

    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()

    //负责对象销毁
    let disposeBag = DisposeBag()//DisposeBag：作用是 Rx 在视图控制器或者其持有者将要销毁的时候，自动释法掉绑定在它上面的资源。它是通过类似“订阅处置机制”方式实现（类似于 NotificationCenter 的 removeObserver）

    override func viewDidLoad() {
        super.viewDidLoad()

        mytableView.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")

        //将数据源数据绑定到tableView上：bind
        musicListViewModel.data.bind(to: mytableView.rx.items(cellIdentifier:"musicCell")) { _, music, cell in
//这是 Rx 基于 cellForRowAt 数据源方法的一个封装。传统方式中我们还要有个 numberOfRowsInSection 方法，使用 Rx 后就不再需要了（Rx 已经帮我们完成了相关工作）
                cell.textLabel?.text = music.name
                cell.detailTextLabel?.text = music.singer
                
        }.disposed(by: disposeBag)

        //tableView点击响应  这是 Rx 基于 UITableView 委托回调方法 didSelectRowAt 的一个封装
        mytableView.rx.modelSelected(Music.self).subscribe(onNext: { music in
            print("你选中的歌曲信息【\(music)】")
        }).disposed(by: disposeBag)

        mytableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("selected the row is \(indexPath.row)")
        }).disposed(by: disposeBag)

    }

}
