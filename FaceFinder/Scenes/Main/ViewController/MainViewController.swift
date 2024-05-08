//
//  MainViewController.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/8/24.
//

import Foundation
import UIKit

class MainViewController: BaseViewController, ViewModelBindableType {
    
    // MARK: - ViewModel -
    
    var viewModel: MainViewModelType!
    
    // MARK: - Private -
    
    
    private var scanButton = UIButton.scanButton
    
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
        
    }
    
    
}
