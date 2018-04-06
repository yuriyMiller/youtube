//
//  SettingsCell.swift
//  youtube
//
//  Created by MacBookPro - Yuriy  on 4/2/18.
//  Copyright © 2018 com.mac.yuriy. All rights reserved.
//

import Foundation
import UIKit

class SettingsCell: BaseCell {
    override func setupViews() {
        super.setupViews()
        print("setupViews From SettingsCell ******")
        self.backgroundColor = UIColor.white
        addSubview(nameLabel)
        addSubview(iconImage)
        addConstraints()
        
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImage.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var settings: Setting? {
        didSet {
            nameLabel.text = settings?.name.rawValue
            if let imageName = settings?.imageName {
                iconImage.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImage.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "settings")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    func addConstraints() {
        addConstrainsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views:iconImage, nameLabel)
        addConstrainsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstrainsWithFormat(format: "V:[v0(30)]", views: iconImage)
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
