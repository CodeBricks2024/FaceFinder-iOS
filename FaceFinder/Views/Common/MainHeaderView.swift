//
//  MainHeaderView.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/14/24.
//

import Foundation
import UIKit

class MainHeaderView: UIView {
    // MARK: - Constants
    
    struct UI {
        
        static let logoHeight: CGFloat = Appearance.Size.headerHeight / 2
        static let logoWidth: CGFloat = logoHeight * 5.9
        
        struct Icon {
            static let logo: UIImage? = Appearance.Icon.logo
        }
        
        
    }
    
    // MARK: - UI Properties
    
    lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UI.Icon.logo
        return view
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit() {
        
        [imgView].forEach(addSubview(_:))
        
        imgView.snp.makeConstraints { make in
            make.height.equalTo(UI.logoHeight)
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(UI.logoWidth)
        }
    }
}
