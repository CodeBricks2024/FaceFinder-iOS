//
//  Extensions+UIScrollView.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import UIKit

extension UIScrollView {
    
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
    
    var contentUntilBotttom: CGFloat {
        return max(contentSize.height - frame.size.height - contentOffset.y, 0)
    }

    var isAtTheBottom: Bool {
        return contentUntilBotttom == 0
    }
    
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
    
    func updateContentViewSize() {
        var newHeight: CGFloat = 0
        for view in subviews {
            let ref = view.frame.origin.y + view.frame.height
            if ref > newHeight {
                newHeight = ref
            }
        }
        let oldSize = contentSize
        let newSize = CGSize(width: oldSize.width, height: newHeight + 50)
        contentSize = newSize
    }
}
