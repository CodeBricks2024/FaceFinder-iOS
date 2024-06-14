//
//  ImageCardCell.swift
//  FaceFinder
//
//  Created by Songkyung Min on 6/5/24.
//

import UIKit
import RxSwift

class ImageCardCell: ImagesCell {
    
    // MARK: - Constants
    
    struct UI {
        static let closeButtonSize: CGFloat = 18
    }
    
    // MARK: - UI Properties
    
    
    override var thumbnailImage: UIImage? {
        didSet {
            if let image = thumbnailImage {
                DispatchQueue.main.async {
                    self.bg.image = image
                }
            }
        }
    }
    
    // MARK: - Properties
    
    var matchInfo: Match!
    var disposeBag = DisposeBag()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.layer.cornerRadius = Appearance.Layer.defaultRadius
        self.disposeBag = DisposeBag()
    }
}
