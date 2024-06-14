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
import RxGesture
import Lottie

class MainViewController: BaseViewController, ViewModelBindableType {
    
    // MARK: - Constants -
    
    struct UI {
        static let leadingTrailingMargin: CGFloat = Appearance.Margin.horizontalMargin * 2
        static let buttonHeight: CGFloat = 74
        static let animSize: CGFloat = 300.0
        static let headerSize: CGFloat = Appearance.Size.headerHeight
    }
    
    // MARK: - ViewModel -
    
    var viewModel: MainViewModelType!
    
    // MARK: - UI Properties -
    
    let headerView = UIView.mainHeaderView
    let scanButton = UIButton.bottomButton
    let animationView = AnimationView.mainAnimationView
    let centerAnimationView = AnimationView.mainCenterAnimationView
    
    // MARK: - Private -
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showAnim()
    }
    
    // MARK: - Set Up UI -
    
    override func setupUI() {
        scanButton.setTitle(.scan, for: .normal)
        
        [headerView, animationView, scanButton].forEach(view.addSubview(_:))
        animationView.addSubview(centerAnimationView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UI.headerSize)
        }
     
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(UI.animSize)
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        centerAnimationView.snp.makeConstraints { make in
            make.width.height.equalTo(UI.animSize/3)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        scanButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UI.leadingTrailingMargin)
            make.trailing.equalToSuperview().offset(-(UI.leadingTrailingMargin))
            make.height.equalTo(UI.buttonHeight)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        animationView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                // TODO: - ADD LATER
            })
            .disposed(by: disposeBag)
    }
    
    private func showAnim() {
        animationView.loopMode = .loop
        animationView.play()
        
        centerAnimationView.loopMode = .loop
        centerAnimationView.play()
    }

    // MARK: - Bind -
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        scanButton.rx.tap
            .observe(on: MainScheduler.instance)
            .bind(to: input.scanAction.inputs)
            .disposed(by: disposeBag)
        
    }
}
