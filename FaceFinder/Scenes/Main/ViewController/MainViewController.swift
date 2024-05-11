//
//  MainViewController.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/8/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MainViewController: BaseViewController, ViewModelBindableType {
    
    // MARK: - ViewModel -
    
    var viewModel: MainViewModelType!
    
    // MARK: - Private -
    
    private var scanButton = UIButton.scanButton
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Set Up UI -
    
    override func setupUI() {
        
        view.addSubview(scanButton)
     
        NSLayoutConstraint.activate([
            scanButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }

    // MARK: - Bind -
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        scanButton.rx.tap
            .observe(on: MainScheduler.instance)
//            .bind(to: input.scanAction.inputs)
            .subscribe({ _ in
                let okAction = UIAlertAction(title: .check, style: .default) { _ in
                    input.scanAction.execute()
                }
                
                let cancelAction = UIAlertAction(title: .cancel, style: .default) { _ in
                }
                
                self.showAlert(type: .two, title: "", message: "", okAction: okAction, cancelAction: cancelAction)
            })
            .disposed(by: disposeBag)
    }
}
