//
//  CustomAVCapturePhotoOutput.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/11/24.
//

import AVFoundation
import RxCocoa

open class CustomAVCapturePhotoOutput: AVCapturePhotoOutput {
    
    public override init() {
        super.init()
    }
    
    weak open var capturePhotoDelegate: AVCapturePhotoCaptureDelegate? // default is nil. weak reference
    
    ////    /**
    ////     @property metadataObjectsDelegate
    ////     @abstract
    ////        The receiver's delegate.
    ////
    ////     @discussion
    ////        The value of this property is an object conforming to the AVCaptureMetadataOutputObjectsDelegate protocol that will receive metadata objects after they are captured. The delegate is set using the setMetadataObjectsDelegate:queue: method.
    ////     */
    open func setAVCapturePhotoDelegate(_ objectsDelegate: AVCapturePhotoCaptureDelegate?) {
        self.capturePhotoDelegate = objectsDelegate
    }
}

extension CustomAVCapturePhotoOutput: HasDelegate {
    public var delegate: AVCapturePhotoCaptureDelegate? {
        get {
            return self.capturePhotoDelegate
        }
        set(newValue) {
            self.setAVCapturePhotoDelegate(newValue)
        }
    }
    
    public typealias Delegate = AVCapturePhotoCaptureDelegate
}
