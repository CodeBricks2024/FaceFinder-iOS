//
//  ImageCardCell.swift
//  FaceFinder
//
//  Created by Songkyung Min on 6/5/24.
//

import Foundation
import UIKit
//import SDWebImage

class ImagesCell: UICollectionViewCell, ClassIdentifiable {
    
    var imageURL: URL? {
        didSet {
            if let url = imageURL {
//                DispatchQueue.main.async {
//                    self.bg.sd_setImage(with: url)
//                }
            }
        }
    }
    
    var thumbnailImage: UIImage? {
        didSet {
            if let image = thumbnailImage {
                DispatchQueue.main.async {
                    self.bg.image = image
                }
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                bg.layer.borderColor = UIColor.primaryColor.cgColor
                bg.layer.borderWidth = 3
            } else {
                bg.layer.borderColor = UIColor.clear.cgColor
                bg.layer.borderWidth = 1
            }
        }
    }
    
    let bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(bg)
        
        bg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
