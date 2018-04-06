//
//  SettingsLauncher.swift
//  youtube
//
//  Created by MacBookPro - Yuriy  on 3/22/18.
//  Copyright © 2018 com.mac.yuriy. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case Term = "Term & private policy"
    case Feedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let settingsCellID = "SettingsCellId"
    let cellHeight: CGFloat = 50
    
    let settingArray: [Setting] = {
        
        let settingsSetting = Setting(name: SettingName.Settings, imageName: "settings")
        let cancelSetting = Setting(name: SettingName.Cancel, imageName: "cancel")
        let feedbcakSetting = Setting(name: SettingName.Feedback, imageName: "feedback")
        let termSetting = Setting(name: SettingName.Term, imageName: "privacy")
        let helpSetting = Setting(name: SettingName.Help, imageName: "help")
        let switchSetting = Setting(name: SettingName.SwitchAccount, imageName: "switch_account")
        
        return [settingsSetting, termSetting, feedbcakSetting, helpSetting, switchSetting, cancelSetting]
    }()
    
    var homeController: HomeViewController?
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let settingName = settingArray[indexPath.row].name
        print(settingName)
        let setting = self.settingArray[indexPath.row]
        handleDismiss(setting: setting)
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
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss(setting:))))
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
    
    @objc func handleDismiss(setting: Setting) {
        print("handleDismiss")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            if let window = UIApplication.shared.keyWindow {
                self.blackView.alpha = 0
                self.colletionView.frame = CGRect(x: 0,
                                                   y: window.frame.height,
                                                  width: self.colletionView.frame.width,
                                                  height: self.colletionView.frame.height)
            }
        }) { (completed: Bool) in
//            let temp: String = setting.name
//            print(temp)
            
            if setting.isKind(of: Setting.self) {
                if setting.name != .Cancel {
                    self.homeController?.showControllerForSettings(setting: setting)
                }
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
