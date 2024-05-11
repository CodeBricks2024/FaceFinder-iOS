//
//  AVCaptureMetadataOutput+Rx.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import AVFoundation
import RxSwift
import RxCocoa

extension Reactive where Base: AVCaptureMetadataOutput {
    
    var delegate: DelegateProxy<AVCaptureMetadataOutput, AVCaptureMetadataOutputObjectsDelegate> {
        return RxAVCaptureMetadataOutputObjectsDelegateProxy.proxy(for: base)
    }
    
    var didOutput: Observable<[AVMetadataObject]> {
        return delegate.methodInvoked(#selector(AVCaptureMetadataOutputObjectsDelegate.metadataOutput(_:didOutput:from:)))
            .map { args in
                let metadataObjects = args[1] as? [AVMetadataObject]
                return metadataObjects ?? []
            }
    }
}
