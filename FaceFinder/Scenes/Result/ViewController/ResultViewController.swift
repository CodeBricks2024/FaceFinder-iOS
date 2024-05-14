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
        static let backButtonSize: CGFloat = Appearance.Size.defaultHeight
    }
    
    
    // MARK: - ViewModel
    
    var viewModel: ResultViewModelType!
    
    // MARK: - UI Properties
    
    lazy var backButton = UIButton.backButton
    
    
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
        [backButton].forEach(view.addSubview(_:))
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.equalToSuperview()
            make.width.height.equalTo(UI.backButtonSize)
        }
    }

    // MARK: - Bind
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        
        backButton.rx.action = input.backAction
        
        
        
    }
    
    
    
    
    
}
