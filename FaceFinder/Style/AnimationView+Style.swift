//
//  AnimationView+Style.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/12/24.
//

import Lottie

extension AnimationView {
        
    static var mainAnimationView: AnimationView = {
        let anim = AnimationView()
        anim.translatesAutoresizingMaskIntoConstraints = false
        anim.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.264).isActive = true
        anim.heightAnchor.constraint(equalTo: anim.widthAnchor).isActive = true
        anim.sizeToFit()
        anim.backgroundBehavior = .pauseAndRestore
        anim.animation = Animation.named("loading")
        anim.isUserInteractionEnabled = true
        return anim
    }()
}
