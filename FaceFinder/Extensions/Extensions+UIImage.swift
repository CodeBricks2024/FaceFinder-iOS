//
//  Extensions+UIImage.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/11/24.
//

import Foundation

import UIKit

extension UIImage {
    func makeFixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return normalizedImage
    }
}

extension CIImage {
    
    func setOrientation() -> UIImage? {
        let currentOrientation: UIDeviceOrientation = .portrait
        let tempImage = self
        var ciImage = tempImage
        switch currentOrientation {
        case .portrait:
            ciImage = tempImage.oriented(forExifOrientation: 6)
        case .landscapeLeft:
            ciImage = tempImage.oriented(forExifOrientation: 3)
        case .landscapeRight:
            ciImage = tempImage.oriented(forExifOrientation: 1)
        default:
            break
        }
        
        guard let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent) else { return nil }
        let uiImage = UIImage(cgImage: cgImage)
        return uiImage
    }
}


extension UIImage {
    func save(at directory: FileManager.SearchPathDirectory,
              pathAndImageName: String,
              createSubdirectoriesIfNeed: Bool = true,
              compressionQuality: CGFloat = 1.0)  -> URL? {
        do {
            let documentsDirectory = try FileManager.default.url(for: directory, in: .userDomainMask,
                                                                    appropriateFor: nil,
                                                                    create: false)
            return save(at: documentsDirectory.appendingPathComponent(pathAndImageName),
                        createSubdirectoriesIfNeed: createSubdirectoriesIfNeed,
                        compressionQuality: compressionQuality)
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
    
    func save(at url: URL,
              createSubdirectoriesIfNeed: Bool = true,
              compressionQuality: CGFloat = 1.0)  -> URL? {
        do {
            if createSubdirectoriesIfNeed {
                try FileManager.default.createDirectory(at: url.deletingLastPathComponent(),
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            }
            guard let data = jpegData(compressionQuality: compressionQuality) else { return nil }
            try data.write(to: url)
            return url
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
}

extension UIImage {
    
    func saveImageLocally(fileName: String) -> String {
        // Obtaining the Location of the Documents Directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(fileName)
        
        if let data = self.pngData() {//jpegData(compressionQuality: 0) {
            do {
                try data.write(to: url) // Writing an Image in the Documents Directory
            } catch {
                print("Unable to Write \(fileName) Image Data to Disk")
            }
        }
        return url.absoluteString
    }
}

