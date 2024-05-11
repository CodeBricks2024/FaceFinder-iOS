//
//  CameraViewController.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/11/24.
//

import UIKit
import RxSwift
import Photos

class CameraViewController: BaseViewController, ViewModelBindableType {
    
    // MARK: - Constants
    
    struct UI {
        static let leadingTrailingMargin: CGFloat = Appearance.Margin.horizontalMargin
        static let verticalMargin: CGFloat =  Appearance.Margin.verticalMargin
        static let backButtonSize: CGFloat = Appearance.Size.defaultHeight
    }
    
    // MARK: - ViewModel
    
    var viewModel: CameraViewModelType!
    
    
    // MARK: - UI Properties
    
    lazy var backButton = UIButton.backButton
    lazy var cameraView = UIView.cameraView
    lazy var footerView = UIStackView.cameraFooterView
    
    
    // MARK: - PHObject Properties
    
    var placeholder: PHObjectPlaceholder?
    
    // MARK: - Private
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startCaptureSession()
    }
    
    // MARK: - Set Up UI
    
    override func setupUI() {
     
        [cameraView, footerView].forEach(view.addSubview(_:))
        cameraView.addSubview(backButton)
        
        cameraView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.equalToSuperview()
            make.width.height.equalTo(UI.backButtonSize)
        }
        
        footerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(cameraView)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        cameraView.photoDelegate = self
    }
    
    // MARK: - Start CameraView AVCaptureSession
    
    func startCaptureSession() {
        
        cameraView.start { error in
            debugPrint("error check: \(error)")
        }
        
        cameraView.stillImageOutput?.rx.capturePhoto(formats: [AVVideoCodecKey: AVVideoCodecType.jpeg], button: footerView.shutterButon.rx.tap)
            .subscribe(onNext: { _ in
                // TODO: - ADD LATER
            })
            .disposed(by: disposeBag)
        
        if let device = cameraView.captureDevice {
            footerView.cameraLightButton.rx.selected
                .observe(on: MainScheduler.instance)
                .bind(to: device.rx.toggleTorch)
                .disposed(by: disposeBag)
        }
        
    }
    
    // MARK: - Bind
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        
    }
}

// MARK: - PhotoAuthorizationHandler

extension CameraViewController: PhotoAuthorizationHandler {
    func AVCaptureDeviceDidChangeAuthorization(status: AVAuthorizationStatus) {
        debugPrint("AVCaptureDeviceDidChangeAuthorization status: \(status.rawValue)")
        switch status {
        case .denied, .notDetermined:
            //            let okAction = UIAlertAction(title: .check, style: .default) { _ in
            //                if let url = URL(string: UIApplication.openSettingsURLString) {
            //                    UIApplication.shared.open(url)
            //                }
            //            }
            //            self.showAlert(type: .two, title: .askCameraAccessTitle, message: .askCameraAccessContents, okAction: okAction, cancelAction: UIAlertAction(title: .close, style: .default, handler: nil))
            //            return
            
            return
            
        case .authorized:
            return
            
        case .restricted:
            return
            
        @unknown default:
            return
        }
    }
    
    func PHPhotoLibraryDidChangeAuthorization(status: PHAuthorizationStatus) {}
}

