//
//  CameraView.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/11/24.
//

import UIKit
import AVFoundation
import Photos


class CameraView: UIView {
    
    // MARK: - Properties
    
    /// Capture Device
    var captureDevice: AVCaptureDevice!
    /// Capture Session
    var captureSession: AVCaptureSession!
    /// AVCapturePhotoOutput
    var stillImageOutput: CustomAVCapturePhotoOutput?
    
    
    func start(completion: ((_ error: String?)->Void) ) {
        guard captureSession == nil else {
            captureSession.startRunning()
            return
        }
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            completion("Unable to open back camera!")
            return
        }
        
        captureDevice = backCamera
        
        if AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if !granted {
                    self?.captureDeviceDidChangeAuthNotify(.video)
                }
            }
        } else if AVCaptureDevice.authorizationStatus(for: .video) == .denied {
            self.captureDeviceDidChangeAuthNotify(.video)
        }
        
        do {
            
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = CustomAVCapturePhotoOutput()//AVCapturePhotoOutput()
            
            guard let output = stillImageOutput else { return }
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(output) {
                captureSession.addInput(input)
                captureSession.addOutput(output)
            }
            
            /// Preview Layer
            let view = AVCaptureVideoPreviewLayer(session: captureSession)
            view.videoGravity = .resizeAspectFill
            view.connection?.videoOrientation = .portrait
            self.layer.addSublayer(view)
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
                DispatchQueue.main.async {
                    view.frame = self.bounds
                }
            }
            
        } catch let error {
            completion(error.localizedDescription)
        }
    }
    
    // MARK: - Access Request
    
    private func captureDeviceDidChangeAuthNotify(_ type: AVMediaType) {
        // Prompting user for the permission to use the camera.
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: type)
        
    }
    
    deinit {
    }
    
    // MARK: - Session Stop
    
    func stop() {
        guard captureSession != nil else {return}
        guard captureSession.isRunning else {return}
        self.captureSession.stopRunning()
    }
    
    // MARK: - Session Resume
    
    func resume() {
        guard self.captureSession != nil else {return}
        guard !self.captureSession.isRunning else {return}
        self.captureSession.startRunning()
    }
}

extension PHAsset {
    var originalFilename: String? {
        if #available(iOS 9.0, *),
            let resource = PHAssetResource.assetResources(for: self).first {
            return resource.originalFilename
        }

        return value(forKey: "filename") as? String
    }
}
