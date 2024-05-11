//
//  UIButton + Rx.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {

    /// Reactive wrapper for `setTitle(_:for:)`
    public func title(for controlState: UIControl.State = []) -> Binder<String?> {
        return Binder(self.base) { button, title -> Void in
            button.setTitle(title, for: controlState)
        }
    }
}

extension Reactive where Base: UIButton {

    /// Reactive wrapper for `setAttributedTitle(_:controlState:)`
    public func attributedTitle(for controlState: UIControl.State = []) -> Binder<NSAttributedString?> {
        return Binder(self.base) { button, attributedTitle -> Void in
            button.setAttributedTitle(attributedTitle, for: controlState)
        }
    }
}

extension Reactive where Base: UIButton {
  var isSelectedCheck: Observable<Bool> {
    let anyObservable = self.base.rx.methodInvoked(#selector(setter: self.base.isSelected))
    let boolObservable = anyObservable
      .flatMap { Observable.from(optional: $0.first as? Bool) }
      .startWith(self.base.isSelected)
      .distinctUntilChanged()
      .share()

    return boolObservable
  }
    
    /// Alternated with button taps to provide
    /// a checkbox behavior by `UIButton`
    var selected: ControlProperty<Bool> {
        let button = self.base
        let source: Observable<Bool> = self.tap
            .map {[weak button] in
                guard let state = button?.isSelected else {
                    return false
                }
                button?.isSelected.toggle()
                return !state
        }
        let binder: AnyObserver<Bool> = self.isSelected.asObserver()

        return ControlProperty(values: source, valueSink: binder)
    }
}
