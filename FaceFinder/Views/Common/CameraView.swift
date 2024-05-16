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
        
        do {
            
            let input = try AVCaptureDeviceInput(device: captureDevice)
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
    
    
    // MARK: - Switch Camera Position
    
    func switchCamera(position: AVCaptureDevice.Position) {
        captureSession.beginConfiguration()
            guard let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput else { return }
            captureSession.removeInput(currentInput)
            
            guard let newDevice = currentInput.device.position == .back ? getCamera(with: .front) : getCamera(with: .back) else { return }
            
            guard let newCameraInput = try? AVCaptureDeviceInput(device: newDevice) else { return }
        
            captureSession.addInput(newCameraInput)
            captureSession.commitConfiguration()
    }
    
    func getCamera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverSession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: position)
        
        return discoverSession.devices.filter {
            $0.position == position
        }.first
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
