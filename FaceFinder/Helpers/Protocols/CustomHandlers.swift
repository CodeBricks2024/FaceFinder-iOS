//
//  CustomHandlers.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/8/24.
//

import AVFoundation
import Photos

/// 사진 정보&미디어 캡처 장치 사용 권한 요청 관리
protocol PhotoAuthorizationHandler {
    /// 미디어 캡처 장치 사용 권한 상태 전달
    func AVCaptureDeviceDidChangeAuthorization(status: AVAuthorizationStatus)
    /// 사진 라이브러리 사용 권한 상태 전달
    func PHPhotoLibraryDidChangeAuthorization(status: PHAuthorizationStatus)
}
