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

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
		resultHandler?(error)
    }
}
