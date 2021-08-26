//
//  MusicController.swift
//  RXSwift_learning_DayByDay
//
//  Created by AlbertYuan on 2020/5/6.
//  Copyright © 2020 JoyReach. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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


// MARK: RxSwift 进行改造
class MusicController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()

    //负责对象销毁
    let disposeBag = DisposeBag()//DisposeBag：作用是 Rx 在视图控制器或者其持有者将要销毁的时候，自动释法掉绑定在它上面的资源。

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")

        //将数据源数据绑定到tableView上
        musicListViewModel.data
            .bind(to: tableView.rx.items(cellIdentifier:"musicCell")) { _, music, cell in
                cell.textLabel?.text = music.name
                cell.detailTextLabel?.text = music.singer
        }.disposed(by: disposeBag)

        //tableView点击响应
        tableView.rx.modelSelected(Music.self).subscribe(onNext: { music in
            print("你选中的歌曲信息【\(music)】")
        }).disposed(by: disposeBag)
    }

}
