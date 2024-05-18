//
//  NavigationView.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/16/24.
//

import UIKit

class NavigationView: UIView {
    
    // MARK: - Constants
    
    struct UI {
        static let buttonSize: CGFloat = Appearance.Size.defaultHeight
        static let leadingTrailingMargin: CGFloat = Appearance.Margin.verticalMargin
    }
    
    // MARK: - UI Properties
    
    lazy var backButton = UIButton.backButton
    lazy var titleLabel = UILabel.headerBoldLabel
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    // MARK: - Set Up Properties
    
    func setUpUI() {
        titleLabel.text = ""
        [backButton, titleLabel].forEach(addSubview(_:))
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UI.leadingTrailingMargin)
            make.width.height.equalTo(UI.buttonSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(UI.buttonSize)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}
