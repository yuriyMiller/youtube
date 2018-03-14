//
//  Extensons.swift
//  youtube
//
//  Created by MacBookPro - Yuriy  on 2/19/18.
//  Copyright © 2018 com.mac.yuriy. All rights reserved.
//
import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstrainsWithFormat(format:String, views:UIView...){
        var viewsDict = [String:UIView]()
        for (index,view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDict[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomUIImageView : UIImageView {
    var imageUrlString: String?
    func loadImageViewByURL(url: String) {
        imageUrlString = url
        self.image = nil
        if let imageFromCache = imageCache.object(forKey:url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: URL(string:url)!, completionHandler: { (data, respose, error) in
            if error != nil {
                print(error ?? "ERROR")
                return
            }
            DispatchQueue.main.async {
                
                
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == url {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: url as AnyObject)
                
            }
        }).resume()
    }
}
