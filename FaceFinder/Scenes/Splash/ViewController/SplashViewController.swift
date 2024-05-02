//
//  SplashViewController.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import Foundation
import UIKit
import RxSwift

class SplashViewController: BaseViewController, ViewModelBindableType {
    
    // MARK: - ViewModel -
    
    var viewModel: SplashViewModelType!
    
    // MARK: - Private -
    
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func setupUI() {
        
    }
    
    // MARK: - Bind -
    
    func bindViewModel() {
        
    }
}
