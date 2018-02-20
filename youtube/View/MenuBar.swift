//
//  MenuBar.swift
//  youtube
//
//  Created by MacBookPro - Yuriy  on 2/19/18.
//  Copyright © 2018 com.mac.yuriy. All rights reserved.
//

import UIKit

class MenuBar : UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        barCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
        addSubview(barCollectionView)
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        barCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.top)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: barCollectionView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: barCollectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let cellID = "cellID"
    let imageViews = ["home", "subscriptions", "trending", "account"]
    
    lazy var barCollectionView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let bcv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        bcv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        bcv.delegate = self
        bcv.dataSource = self
        return bcv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = barCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named:imageViews[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named:"home")
        imv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return imv
    }()
    
    override var isSelected: Bool {
        didSet {
            selectButton(isSelected:isSelected)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            selectButton(isSelected:isHighlighted)
        }
    }
    func selectButton(isSelected: Bool) {
        imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
    }
    
    override func setupViews() {
        //super.setupViews()
        addSubview(imageView)
        addConstrainsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstrainsWithFormat(format: "V:[v0(28)]", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

    }
}
