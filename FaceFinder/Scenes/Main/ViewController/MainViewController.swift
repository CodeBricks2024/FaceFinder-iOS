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
        static let imgSize: CGFloat = 50
        static let animSize: CGFloat = 300.0
        
    }
    
    // MARK: - ViewModel -
    
    var viewModel: MainViewModelType!
    
    // MARK: - UI Properties -
    
    let scanButton = UIButton.bottomButton
    let animationView = AnimationView.mainAnimationView
    
    lazy var scanImage: UIImageView = {
        let img = UIImageView()
        img.image = Appearance.Icon.scanzone
        img.contentMode = .scaleAspectFill
        return img
    }()
    
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
        
        [animationView, scanButton].forEach(view.addSubview(_:))
        animationView.addSubview(scanImage)
     
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(UI.animSize)
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        scanButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UI.leadingTrailingMargin)
            make.trailing.equalToSuperview().offset(-(UI.leadingTrailingMargin))
            make.height.equalTo(UI.buttonHeight)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        scanImage.snp.makeConstraints { make in
            make.width.height.equalTo(UI.imgSize)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
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
