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
import StoreKit

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
    lazy var nameLabel = UILabel.headerBoldLabel
    lazy var emotionLabel = UILabel.headerBoldLabel
    lazy var emojiLabel = UILabel.emojiLabel
    
    // MARK: - Private
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 14.0, *) {
          guard let scene = UIApplication
            .shared
            .connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
          else { return }
          SKStoreReviewController.requestReview(in: scene)
        } else {
          SKStoreReviewController.requestReview()
        }
    }
    
    // MARK: - Set Up UI
    
    override func setupUI() {
        navView.titleLabel.text = .resultTitle
        nameLabel.textColor = UIColor.primaryColor
        [navView, originalImgview, nameLabel, imageCollectionView, emotionLabel, emojiLabel].forEach(view.addSubview(_:))
        
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
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(originalImgview.snp.bottom).offset(UI.imgViewVerticalMargin)
            make.leading.equalTo(originalImgview.snp.leading)
            make.trailing.equalTo(originalImgview.snp.trailing)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(UI.imgWidth/2)
        }
        
        emotionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(originalImgview.snp.width)
        }
        
        emojiLabel.snp.makeConstraints { make in
            make.top.equalTo(emotionLabel.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(UI.imgWidth/2)
        }
        
        configureCollectionView()
    }
    
    // MARK: - Configure CollectionView FlowLayout
    
    func configureCollectionView() {
        guard let flowLayout = imageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        //        let width = floor((UIScreen.main.bounds.width - 24 - 24 - (cellPadding * (cellsPerRow - 1))) / 4)
        //        let height = floor(width / imageRatio)
        //
        flowLayout.minimumLineSpacing = 8
        //        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: UI.contentsViewHeight, height: UI.contentsViewHeight * 1.2)
        flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: UI.imgViewVerticalMargin, bottom: 0.0, right: UI.imgViewVerticalMargin)
        flowLayout.scrollDirection = .horizontal
        flowLayout.invalidateLayout()
    }
    
    // MARK: - Bind
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        output.originalPhotoImage
            .observe(on: MainScheduler.instance)
            .bind(to: originalImgview.rx.image)
            .disposed(by: disposeBag)
        
        
        output.thumbnailData
            .observe(on: MainScheduler.instance)
            .bind(to: imageCollectionView.rx.items) { cv, index, element in
                let cell = cv.dequeueReusableCell(withCellType: ImageCardCell.self, forIndexPath: IndexPath(row: index, section: 0))
                cell.bg.layer.cornerRadius = Appearance.Layer.defaultRadius
                cell.matchInfo = element
                cell.thumbnailImage = UIImage(base64: cell.matchInfo.image, withPrefix: false)
                return cell
            }
            .disposed(by: disposeBag)
        
        imageCollectionView.rx.itemSelected
            .flatMap { [weak self] indexPath -> Observable<ImageCardCell> in
                guard let `self` = self else { return .empty() }
                guard let cell = self.imageCollectionView.cellForItem(at: indexPath) as? ImageCardCell else { return .empty() }
                return .just(cell)
            }
            .subscribe(onNext: { cell in
                input.selectThumbnailSubject.onNext(cell.matchInfo)
            })
            .disposed(by: disposeBag)
        
        output.closestMatchName
            .observe(on: MainScheduler.instance)
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        input.selectThumbnailSubject
            .observe(on: MainScheduler.instance)
            .unwrap()
            .map { $0.name }
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        input.selectThumbnailSubject
            .observe(on: MainScheduler.instance)
            .unwrap()
            .map { UIImage(base64: $0.image, withPrefix: false) }
            .bind(to: originalImgview.rx.image)
            .disposed(by: disposeBag)
        
        output.emotionName
            .observe(on: MainScheduler.instance)
            .bind(to: emotionLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.emoji
            .observe(on: MainScheduler.instance)
            .bind(to: emojiLabel.rx.text)
            .disposed(by: disposeBag)
        
        navView.backButton.rx.action = input.backAction
        
        
    }
}


