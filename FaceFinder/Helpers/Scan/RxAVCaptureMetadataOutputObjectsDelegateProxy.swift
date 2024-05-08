//
//  RxAVCaptureMetadataOutputObjectsDelegateProxy.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import AVFoundation
import RxSwift
import RxCocoa

class RxAVCaptureMetadataOutputObjectsDelegateProxy
    : DelegateProxy<AVCaptureMetadataOutput, AVCaptureMetadataOutputObjectsDelegate>, DelegateProxyType, AVCaptureMetadataOutputObjectsDelegate {
    
    static func currentDelegate(for object: AVCaptureMetadataOutput) -> AVCaptureMetadataOutputObjectsDelegate? {
        return object.metadataObjectsDelegate
    }
    
    static func setCurrentDelegate(_ delegate: AVCaptureMetadataOutputObjectsDelegate?, to object: AVCaptureMetadataOutput) {
        object.setMetadataObjectsDelegate(delegate, queue: .main)
    }
    
    public init(captureMedatadaOutput: AVCaptureMetadataOutput) {
        super.init(parentObject: captureMedatadaOutput, delegateProxy: RxAVCaptureMetadataOutputObjectsDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        register { RxAVCaptureMetadataOutputObjectsDelegateProxy(captureMedatadaOutput: $0) }
    }
}
