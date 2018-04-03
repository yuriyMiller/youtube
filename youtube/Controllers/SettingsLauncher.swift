//
//  SettingsLauncher.swift
//  youtube
//
//  Created by MacBookPro - Yuriy  on 3/22/18.
//  Copyright © 2018 com.mac.yuriy. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let settingsCellID = "SettingsCellId"
    let cellHeight: CGFloat = 50
    
    let settingArray: [Setting] = {
        return [Setting(name: "Settings", imageName: "settings"),
                Setting(name: "Term & private policy", imageName: "privacy"),
                Setting(name: "Send Feedback", imageName: "feedback"),
                Setting(name: "Help", imageName: "help"),
                Setting(name: "Switch Account", imageName: "switch_account"),
                Setting(name: "Cancel", imageName: "cancel")]
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: settingsCellID, for: indexPath) as! SettingsCell
        cell.settings = settingArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    let blackView = UIView()
    
    let colletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    @objc func showSettings() {
        print("handleMore")
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            
            
            
            window.addSubview(colletionView)
            let height: CGFloat = CGFloat(settingArray.count) * cellHeight
            let y = window.frame.height - height
            colletionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.colletionView.frame = CGRect(x: 0, y: y, width: self.colletionView.frame.width, height: self.colletionView.frame.height)
            }, completion: nil)
            
        }
    }
    
    @objc func handleDismiss() {
        print("handleDismiss")
        UIView.animate(withDuration: 0.5) {
            if let window = UIApplication.shared.keyWindow {
                self.blackView.alpha = 0
                self.colletionView.frame = CGRect(x: 0, y: window.frame.height, width: self.colletionView.frame.width, height: self.colletionView.frame.height)
            }
        }
    }
    
    override init() {
        super.init()
        colletionView.dataSource = self
        colletionView.delegate = self
        colletionView.register(SettingsCell.self, forCellWithReuseIdentifier: "SettingsCellId")
    }
}
