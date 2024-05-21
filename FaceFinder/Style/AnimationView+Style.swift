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
        anim.sizeToFit()
        anim.backgroundBehavior = .pauseAndRestore
        anim.animation = Animation.named("mainLoading")
        anim.isUserInteractionEnabled = true
        return anim
    }()
    
    static var mainCenterAnimationView: AnimationView = {
        let anim = AnimationView()
        anim.sizeToFit()
        anim.backgroundBehavior = .pauseAndRestore
        anim.animation = Animation.named("centerLoading")
        anim.isUserInteractionEnabled = true
        anim.contentMode = .scaleAspectFit
        return anim
    }()
}
