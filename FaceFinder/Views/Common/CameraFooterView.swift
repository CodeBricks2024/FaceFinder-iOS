//
//  CameraFooterView.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/11/24.
//

import UIKit

class CameraFooterView: UIStackView {
    
    // MARK: - Constants
    
    struct UI {
        static let dimmedViewHeight: CGFloat = 92 + UIApplication.safeAreaInsets.bottom
        static let leadingTrailingMargin: CGFloat = Appearance.Margin.horizontalMargin
        static let verticalMargin: CGFloat =  Appearance.Margin.verticalMargin
        static let footerButtonHeight: CGFloat = Appearance.Size.defaultHeight
        static let lightButtonTopMargin: CGFloat = 28
        static let shutterButtonSize: CGFloat = 60
        static let lightButtonSize: CGFloat = 36
        static let finishButtonWidth: CGFloat = 60
        static let contentsViewHeight: CGFloat = 72
        
        static let buttonSize: CGFloat = 30.0
        
        struct Color {
            static let dimmedColor: UIColor = .black
            static let borderColor: UIColor = .blue
        }
        
        struct Icon {
            static let shutter: UIImage? = Appearance.Image.shutter
        }
    }
    
    // MARK: - UI Properties
    
    lazy var dimmedView = UIStackView.horizontalStackView
    
    lazy var contentsView = UIView.plainView
    
    lazy var shutterButon: UIButton = {
        let button = UIButton()
        button.setImage(UI.Icon.shutter, for: .normal)
        return button
    }()
    
    lazy var albumButton = UIButton.albumButton
    lazy var cameraSwitchButton = UIButton.cameraSwitchButton
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit() {
        self.axis = .vertical
        self.distribution = .fill
        
        dimmedView.backgroundColor = UI.Color.dimmedColor
        
        [contentsView, dimmedView].forEach(self.addArrangedSubview(_:))
        
        [albumButton,shutterButon, cameraSwitchButton].forEach(dimmedView.addArrangedSubview(_:))
        
        
        dimmedView.snp.makeConstraints { make in
            make.height.equalTo(UI.dimmedViewHeight)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentsView.snp.makeConstraints { make in
            make.height.equalTo(UI.contentsViewHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(dimmedView.snp.top)
        }

        configureCollectionView()
    }
    
    // MARK: - Configure CollectionView FlowLayout
    
    func configureCollectionView() {
//        guard let flowLayout = photoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//
////        let width = floor((UIScreen.main.bounds.width - 24 - 24 - (cellPadding * (cellsPerRow - 1))) / 4)
////        let height = floor(width / imageRatio)
////
////        flowLayout.minimumLineSpacing = 8
////        flowLayout.minimumInteritemSpacing = 0
//        flowLayout.itemSize = CGSize(width: UI.contentsViewHeight, height: UI.contentsViewHeight)
//        flowLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 24.0, bottom: 24.0, right: 24.0)
    }
}
