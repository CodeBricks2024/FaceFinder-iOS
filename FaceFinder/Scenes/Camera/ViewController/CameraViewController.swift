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
        static let overlayWidth: CGFloat = 330.0
        static let overalyHeight: CGFloat = overlayWidth * 1.3
    }
    
    // MARK: - ViewModel
    
    var viewModel: CameraViewModelType!
    
    
    // MARK: - UI Properties
    
    lazy var backButton = UIButton.backButton
    lazy var cameraView = UIView.cameraView
    lazy var footerView = UIStackView.cameraFooterView
    lazy var overlayView: UIImageView = {
        let view = UIImageView(image: Appearance.Image.overlay)
        return view
    }()
    
    
    // MARK: - PHObject Properties
    
    var placeholder: PHObjectPlaceholder?
    
    // MARK: - Private
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startCaptureSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Set Up UI
    
    override func setupUI() {
     
        [cameraView, footerView].forEach(view.addSubview(_:))
        [backButton, overlayView].forEach(cameraView.addSubview(_:))

        cameraView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaInsets.bottom)
        }
        
        overlayView.snp.makeConstraints { make in
            make.width.equalTo(UI.overlayWidth)
            make.height.equalTo(UI.overalyHeight)
            make.center.equalTo(cameraView)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(cameraView.snp.topMargin)
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
        
        
        cameraView.stillImageOutput?.rx.photoOutput
            .observe(on: MainScheduler.instance)
            .throttle(.milliseconds(Constants.Unit.DEFAULT_MILLISECONDS), scheduler: MainScheduler.instance)
            .unwrap()
            .do(onNext: { [weak self] photo in
//                self?.handleSavePhoto(photo: photo)
                guard let photo = photo.fileDataRepresentation() else { return }
                guard let image = UIImage(data: photo)?.makeFixOrientation() else { return }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    guard let placeHolder = self?.placeholder else { return }
                    guard let asset = PHAsset.fetchAssets(withLocalIdentifiers: [placeHolder.localIdentifier], options: .none).firstObject, let fileName = asset.originalFilename else { return }
                    
                    let uploadedPath = image.saveImageLocally(fileName: fileName)
                    let object = CapturedPhotoData(filePath: uploadedPath)
                    self?.viewModel.input.capturedPhotoData.onNext(object)
                }
            })
            .flatMap({ photo -> Observable<UIImage> in
                guard let previewPixelBuffer = photo.previewPixelBuffer else { return .empty() }
                let ciImage = CIImage(cvPixelBuffer: previewPixelBuffer)
                guard let uiImage = ciImage.setOrientation() else { return .empty() }
                return .just(uiImage)
            })
            .bind(to: viewModel.input.photoInputSubject)
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
        
        
        backButton.rx.action = input.backAction
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

