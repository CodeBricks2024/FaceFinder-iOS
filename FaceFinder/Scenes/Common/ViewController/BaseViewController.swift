//
//  BaseViewController.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import Foundation
import UIKit


class BaseViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
    }
    
    // MARK: - Set Up UI -
    
    func setupUI() {
        view.backgroundColor = .white
    }
}
