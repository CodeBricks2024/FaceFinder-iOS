//
//  CameraViewController.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/8/24.
//

import Foundation
import UIKit
import AVFoundation
import Photos
import SnapKit

class CameraViewController: BaseViewController, ViewModelBindableType {
    
    // MARK: - ViewModel -
    
    var viewModel: CameraViewModelType!
    
    
    // MARK: - Private -
    
    private var overlay: UIView!
    private let captureSession = AVCaptureSession()
    
    private var photoDelegate: PhotoAuthorizationHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkCameraPermission()
    }
    
    override func setupUI() {
        self.photoDelegate = self
        
        let previewView = PreviewView(session: captureSession)
        
        [previewView].forEach(view.addSubview(_:))
        
//        overlay = createOverlay()
//        [overlay, backButton].forEach(previewView.addSubview(_:))
        
        previewView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    // MARK: - Permission Request -
    
    private func checkCameraPermission() {        
        if AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let `self` = self else { return }
                if !granted {
                    self.accessRequestCamera(.video)
                }
            }
        } else if AVCaptureDevice.authorizationStatus(for: .video) == .denied {
            self.accessRequestCamera(.video)
        }
    }
    
    private func accessRequestCamera(_ type: AVMediaType) {
        // Prompting user for the permission to use the camera.
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: type)
        
        AVCaptureDevice.requestAccess(for: type) { granted in
            DispatchQueue.main.async {
                self.photoDelegate.AVCaptureDeviceDidChangeAuthorization(status: cameraAuthorizationStatus)
            }
        }
    }
    
    // MARK: - Bind -
    
    func bindViewModel() {
        
    }
    
    
}

extension CameraViewController: PhotoAuthorizationHandler {
    func AVCaptureDeviceDidChangeAuthorization(status: AVAuthorizationStatus) {
        switch status {
            case .denied, .notDetermined:
                let okAction = UIAlertAction(title: .check, style: .default) { _ in
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
                self.showAlert(type: .two, title: .askCameraAccessTitle, message: .askCameraAccessContents, okAction: okAction, cancelAction: UIAlertAction(title: .close, style: .default, handler: nil))
                return

            case .authorized:
                return

            case .restricted:
                return

            @unknown default:
                return
        }
    }
    
    func PHPhotoLibraryDidChangeAuthorization(status: PHAuthorizationStatus) {
        
    }
}
