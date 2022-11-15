//
//  UIImageView+Extention.swift
//  Github Project
//
//  Created by youssef on 15/11/2022.
//
import UIKit

var ImageCache = NSCache<AnyObject , AnyObject> ()

extension UIImageView {
    
    func Load(urlString: String)  {
        
        guard let url = URL(string: urlString) else {return}
        
        if let image = ImageCache.object(forKey: urlString as NSString) as?
            UIImage{
            self.image = image
        }
        DispatchQueue.global().async { [weak self] in
            
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        ImageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}
