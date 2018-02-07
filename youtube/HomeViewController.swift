//
//  ViewController.swift
//  youtube
//
//  Created by MacBookPro - Yuriy  on 2/7/18.
//  Copyright © 2018 com.mac.yuriy. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "HOME"
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 200)
    }
    

    
    


}

class VideoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews() {
        addSubview(thumbnailImageView)
        addConstraint(<#T##constraint: NSLayoutConstraint##NSLayoutConstraint#>)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let thumbnailImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        
        return imageView
    }()
    

}
