//
//  BaseViewController.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import Foundation
import UIKit


class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Set Up UI -
    
    func setupUI() {
    }
}
