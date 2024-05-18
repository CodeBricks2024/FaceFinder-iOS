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
        static let imgViewVerticalMargin: CGFloat = Appearance.Margin.horizontalMargin
        static let navHeight: CGFloat = Appearance.Size.headerHeight
        static let imgViewLeadingTrailingMargin: CGFloat = Appearance.Margin.imgViewMargin
        static let imgWidth: CGFloat = UIScreen.main.bounds.width - imgViewLeadingTrailingMargin * 2
    }
    
    
    // MARK: - ViewModel
    
    var viewModel: ResultViewModelType!
    
    // MARK: - UI Properties
    
    lazy var navView = UIView.navView
    lazy var originalImgview = UIImageView.roundedImgView
    
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
        [navView, originalImgview].forEach(view.addSubview(_:))
        
        navView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UI.navHeight)
        }
        
        originalImgview.snp.makeConstraints { make in
            make.top.equalTo(navView.snp.bottom).offset(UI.imgViewVerticalMargin)
            make.leading.equalToSuperview().offset(UI.imgViewLeadingTrailingMargin)
            make.trailing.equalToSuperview().offset(-(UI.imgViewLeadingTrailingMargin))
            make.width.height.equalTo(UI.imgWidth)
        }
    }

    // MARK: - Bind
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        output.originalPhotoImage
            .observe(on: MainScheduler.instance)
            .bind(to: originalImgview.rx.image)
            .disposed(by: disposeBag)
        
        navView.backButton.rx.action = input.backAction
        
    }
}
