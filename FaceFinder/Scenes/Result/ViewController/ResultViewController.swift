//
//  ResultViewController.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

class ResultViewController: BaseViewController, ViewModelBindableType {
    
    // MARK: - Constants
    
    struct UI {
        static let leadingTrailingMargin: CGFloat = Appearance.Margin.horizontalMargin
        
        static let navHeight: CGFloat = Appearance.Size.headerHeight
    }
    
    
    // MARK: - ViewModel
    
    var viewModel: ResultViewModelType!
    
    // MARK: - UI Properties
    
    lazy var navView = UIView.navView
    
    // MARK: - Private
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    // MARK: - Set Up UI
    
    override func setupUI() {
        navView.titleLabel.text = .resultTitle
        [navView].forEach(view.addSubview(_:))
        
        navView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UI.navHeight)
        }
    }

    // MARK: - Bind
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        navView.backButton.rx.action = input.backAction
        
    }
}
