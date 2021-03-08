//
//  MasterViewController.swift
//  Multikeyous
//
//  Created by Yongun Lim on 2021/03/08.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MasterViewController: UIViewController {
    
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var contentContainer: UIView!
    
    let masterViewModel = MasterViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    func setupUI() {
        headerContainer.setShadow()
    }
    
    func setupBindings() {
        masterViewModel.visibleTabItem
            .asDriver()
            .drive(onNext: { [weak self] current in
                guard let strongSelf = self else { return }
                strongSelf.setContentView(type: current)
            }).disposed(by: disposeBag)
    }
    
    func setContentView(type: TabItemType) {
        guard let viewController = type.getViewController() else { return }
        contentContainer.setEmpty()
        self.addChild(viewController)
        self.contentContainer.addSubview(viewController.view)
        viewController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    @IBAction func actionTab(_ sender: UIButton) {
        guard let type = TabItemType(rawValue: sender.tag) else { return }
        masterViewModel.visibleTabItem.accept(type)
    }
}
