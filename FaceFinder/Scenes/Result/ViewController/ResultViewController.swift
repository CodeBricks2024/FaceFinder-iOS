//
//  ResultViewController.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class ResultViewController: BaseViewController, ViewModelBindableType {
    
    // MARK: - Constants
    
    struct UI {
        static let imgViewVerticalMargin: CGFloat = Appearance.Margin.horizontalMargin
        static let navHeight: CGFloat = Appearance.Size.headerHeight
        static let imgViewLeadingTrailingMargin: CGFloat = Appearance.Margin.imgViewMargin
        static let imgWidth: CGFloat = UIScreen.main.bounds.width - imgViewLeadingTrailingMargin * 2
        static let contentsViewHeight: CGFloat = 72
    }
    
    
    // MARK: - ViewModel
    
    var viewModel: ResultViewModelType!
    
    // MARK: - UI Properties
    
    lazy var navView = UIView.navView
    lazy var originalImgview = UIImageView.roundedImgView
    lazy var imageCollectionView: ImageCollectionView = {
        let cv = ImageCollectionView(direction: .horizontal)
        cv.register(cellType: ImageCardCell.self)
        return cv
    }()
    
    // MARK: - Private
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    // MARK: - Set Up UI
    
    override func setupUI() {
        navView.titleLabel.text = .resultTitle
        [navView, originalImgview, imageCollectionView].forEach(view.addSubview(_:))
        
        navView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UI.navHeight)
        }
        
        originalImgview.snp.makeConstraints { make in
            make.top.equalTo(navView.snp.bottom).offset(UI.imgViewVerticalMargin)
            make.leading.equalToSuperview().offset(UI.imgViewLeadingTrailingMargin)
            make.trailing.equalToSuperview().offset(-(UI.imgViewLeadingTrailingMargin))
            make.width.height.equalTo(UI.imgWidth)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-(UI.imgViewLeadingTrailingMargin))
        }
        
        configureCollectionView()
    }
    
    // MARK: - Configure CollectionView FlowLayout
    
    func configureCollectionView() {
        guard let flowLayout = imageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

//        let width = floor((UIScreen.main.bounds.width - 24 - 24 - (cellPadding * (cellsPerRow - 1))) / 4)
//        let height = floor(width / imageRatio)
//
//        flowLayout.minimumLineSpacing = 8
//        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: UI.contentsViewHeight, height: UI.contentsViewHeight)
//        flowLayout.sectionInset = UIEdgeInsets(top: 24.0, left: 24.0, bottom: 24.0, right: 24.0)
    }

    // MARK: - Bind
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        output.originalPhotoImage
            .observe(on: MainScheduler.instance)
            .bind(to: originalImgview.rx.image)
            .disposed(by: disposeBag)
        
        output.thumbnailPhotoData
            .observe(on: MainScheduler.instance)
            .bind(to: imageCollectionView.rx.items) { cv, index, element in
                let cell = cv.dequeueReusableCell(withCellType: ImageCardCell.self, forIndexPath: IndexPath(row: index, section: 0))
                cell.thumbnailImage = element
                return cell
            }
            .disposed(by: disposeBag)
        
        navView.backButton.rx.action = input.backAction
        
    }
}
