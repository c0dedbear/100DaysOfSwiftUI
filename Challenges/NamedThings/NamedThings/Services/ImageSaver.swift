//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Михаил Медведев on 13.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import UIKit

final class ImageSaver: NSObject {

	var resultHandler: ((Error?) -> Void)?

	private var archiveURL: URL {
		getDocumentsDirectory()
			.appendingPathComponent("images")
			.appendingPathExtension("plist")
	}

	private func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}

	func removeFilesAt(filepaths: [String], completion: (() -> Void)?) {
		for filepath in filepaths {
			let fileURL = getDocumentsDirectory().appendingPathComponent(filepath)
			do {
				try FileManager.default.removeItem(at: fileURL)
			}
			catch {
//				assertionFailure(error.localizedDescription)
			}
		}
		completion?()
	}

	func storeImage(_ image: UIImage, filename: String, completion: (() -> Void)?) {
		if let data = image.jpegData(compressionQuality: 1) {
			let filePath = getDocumentsDirectory().appendingPathComponent(filename)
			do {
				try data.write(to: filePath)
				completion?()
			}
			catch {
				assertionFailure(error.localizedDescription)
			}
		}
	}

	func loadImage(filename: String, completion: (UIImage?) -> Void) {
		let filePath = getDocumentsDirectory().appendingPathComponent(filename)

		if let data = try? Data(contentsOf: filePath) {
			if let image = UIImage(data: data) {
				completion(image)
			}
		} else {
			completion(nil)
		}
	}

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
		resultHandler?(error)
    }
}
