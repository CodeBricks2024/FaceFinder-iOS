//
//  RxAVCapturePhotoCaptureDelegateProxy.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/11/24.
//

import AVFoundation
import RxSwift
import RxCocoa

class RxAVCapturePhotoCaptureDelegateProxy: DelegateProxy<CustomAVCapturePhotoOutput, AVCapturePhotoCaptureDelegate>, DelegateProxyType, AVCapturePhotoCaptureDelegate {
    
    static func currentDelegate(for object: CustomAVCapturePhotoOutput) -> AVCapturePhotoCaptureDelegate? {
//        debugPrint("capture current delegate: \(object.capturePhotoDelegate)")
        return object.capturePhotoDelegate
    }
    
    static func setCurrentDelegate(_ delegate: AVCapturePhotoCaptureDelegate?, to object: CustomAVCapturePhotoOutput) {
//        debugPrint("catprure set delegate: \(delegate)")
        object.setAVCapturePhotoDelegate(delegate)
    }
    
    public init(captureOutput: CustomAVCapturePhotoOutput) {
        super.init(parentObject: captureOutput, delegateProxy: RxAVCapturePhotoCaptureDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        register { RxAVCapturePhotoCaptureDelegateProxy(captureOutput: $0) }
    }
}
