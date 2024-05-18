//
//  AVCaptureDevice+Rx.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/11/24.
//

import AVFoundation
import RxSwift
import RxCocoa

extension Reactive where Base: AVCaptureDevice {
    
    // MARK: - Toggle Torch
    
    public var toggleTorch: Binder<Bool> {
        return Binder(self.base) { device, on in
            if device.hasTorch {
                guard let _ = try? device.lockForConfiguration() else {
                    debugPrint("Torch could not be used")
                    return
                }
                if on {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            } else {
                debugPrint("Torch is not available")
            }
        }
    }    
}
