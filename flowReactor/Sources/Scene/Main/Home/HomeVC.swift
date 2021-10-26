//
//  HomeVC.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import UIKit
import RxFlow
import RxCocoa
import ReactorKit

final class HomeVC: UIViewController{
    var disposeBag: DisposeBag = .init()
    
    private let tableView = UITableView().then{
        $0.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reusableID)
        $0.rowHeight = 50
        $0.separatorStyle = .none
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
}

extension HomeVC: View{
    func bind(reactor: HomeReactor) {
        bindView(reactor)
        bindAction(reactor)
        bindState(reactor)
    }
    private func bindView(_ reactor: HomeReactor){
        tableView.rx.modelSelected(Movie.self)
            .map { $0.description }
            .map{ Reactor.Action.itemSelected(title: $0)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    private func bindAction(_ reactor: HomeReactor){
        self.rx.viewWillAppear
            .map{ _ in Reactor.Action.loadData }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    private func bindState(_ reactor: HomeReactor){
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.instance)
        
        sharedState
            .compactMap{ $0.movies }
            .bind(to: tableView.rx.items(
                cellIdentifier: HomeCell.reusableID,
                                         cellType: HomeCell.self)
            ){ index, model, cell in
                cell.model = model
            }
            .disposed(by: disposeBag)
        
    }
    private func fetchCellTitleText(index: IndexPath) -> String?{
        guard let cell = self.tableView.cellForRow(at: index) as? HomeCell else { return nil }
        return cell.titleLabel.text
    }
}

