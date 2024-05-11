//
//  AVCapturePhotoOutput+Rx.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/11/24.
//

import AVFoundation
import RxSwift
import RxCocoa

extension Reactive where Base: CustomAVCapturePhotoOutput {
    
    /// Reactive wrapper for `delegate`.
    ///
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    var delegate: DelegateProxy<CustomAVCapturePhotoOutput, AVCapturePhotoCaptureDelegate> {
        return RxAVCapturePhotoCaptureDelegateProxy.proxy(for: base)
    }
    
    var photoOutput: Observable<AVCapturePhoto?> {
        return delegate.methodInvoked(#selector(AVCapturePhotoCaptureDelegate.photoOutput(_:didFinishProcessingPhoto:error:)))
            .map { args -> AVCapturePhoto? in
                let outputObjects = args[1] as? AVCapturePhoto
                return outputObjects ?? nil
            }
    }
    
    func capturePhoto(formats: [String: Any]?, button: ControlEvent<Void>) -> Observable<Void> {
        return button
            .asObservable()
            .flatMap { [weak base] _ -> Observable<Void> in
                let settings = AVCapturePhotoSettings(format: formats)
                if settings.availablePreviewPhotoPixelFormatTypes.count > 0 {
                    settings.previewPhotoFormat = [
                        kCVPixelBufferPixelFormatTypeKey : settings.availablePreviewPhotoPixelFormatTypes.first!,
                        kCVPixelBufferWidthKey : 720,
                        kCVPixelBufferHeightKey : 720
                    ] as [String: Any]
                }
                
                guard let delegate = delegate as? AVCapturePhotoCaptureDelegate else { return .empty() }
                guard let output = base else { return .empty() }
                return .just(output.capturePhoto(with: settings, delegate: delegate))
            }
    }
    
    //    public func setDelegate(_ delegate: AVCapturePhotoCaptureDelegate) -> Disposable {
    //        RxAVCapturePhotoCaptureDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
    //    }
}
