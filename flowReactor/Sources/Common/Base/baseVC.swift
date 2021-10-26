//
//  baseVC.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import UIKit

class baseVC: UIViewController{
    // MARK: - Properties
    let bound = UIScreen.main.bounds
    
    // MARK: - Lifecycle
    @available(*, unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    // MAKR: - Helpers
    func configureVC(){view.backgroundColor = .white}
}
