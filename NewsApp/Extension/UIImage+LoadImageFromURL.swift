//
//  UIImage+LoadImageFromURL.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 14/05/24.
//

import UIKit

extension UIImageView {
    func load(url: URL?, fallbackImage: UIImage? = nil) {
        guard let url = url else {
            self.image = fallbackImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.image = fallbackImage
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self?.image = fallbackImage
                }
            }
        }
    }
}
