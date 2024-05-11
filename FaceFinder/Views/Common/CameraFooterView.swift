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
        static let borderWidth: CGFloat = 4
        static let shutterButtonSize: CGFloat = 60
        static let buttonRadius: CGFloat = 30
        static let lightButtonSize: CGFloat = 36
        static let finishButtonWidth: CGFloat = 60
        static let contentsViewHeight: CGFloat = 72
        
        struct Color {
            static let dimmedColor: UIColor = .black
            static let borderColor: UIColor = .blue
        }
    }
    
    // MARK: - UI Properties
    
    lazy var dimmedView = UIView.plainView
    
    lazy var contentsView = UIView.plainView
    
    lazy var shutterButon: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = UI.buttonRadius
        button.layer.borderWidth = UI.borderWidth
        button.layer.borderColor = UI.Color.borderColor.cgColor
        return button
    }()
    
    lazy var cameraLightButton = UIButton.backButton
    
    
    lazy var finishButon: UIButton = {
        let button = UIButton()
        button.backgroundColor = UI.Color.borderColor
        button.setTitle("finish", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .mediumFont(with: 16)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        return button
    }()
    
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
        [shutterButon, cameraLightButton].forEach(dimmedView.addSubview(_:))
        [finishButon].forEach(contentsView.addSubview(_:))
        
        dimmedView.snp.makeConstraints { make in
            make.height.equalTo(UI.dimmedViewHeight)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentsView.snp.makeConstraints { make in
            make.height.equalTo(UI.contentsViewHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(dimmedView.snp.top)
        }
        
        shutterButon.snp.makeConstraints { make in
            make.top.equalTo(dimmedView.snp.top).offset(UI.verticalMargin)
            make.width.height.equalTo(UI.shutterButtonSize)
            make.centerX.equalTo(dimmedView.snp.centerX)
        }
        
        cameraLightButton.snp.makeConstraints { make in
            make.top.equalTo(dimmedView.snp.top).offset(UI.lightButtonTopMargin)
            make.width.height.equalTo(UI.lightButtonSize)
            make.trailing.equalToSuperview().offset(-(UI.leadingTrailingMargin))
        }
        
        finishButon.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(UI.finishButtonWidth)
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
