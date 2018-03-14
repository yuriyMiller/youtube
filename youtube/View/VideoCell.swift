//
//  ViewCell.swift
//  youtube
//
//  Created by MacBookPro - Yuriy  on 2/19/18.
//  Copyright © 2018 com.mac.yuriy. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("From base cell init ******")
        setupViews()
    }
    
    func setupViews() {
        print("From base cell ******")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoCell: BaseCell {

    
    var titleTextHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        addConstrainsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstrainsWithFormat(format: "H:|-16-[v0(44)]", views: profileImageView)
        addConstrainsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, profileImageView, separatorView)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        titleTextHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
        addConstraint(titleTextHeightConstraint!)
        //NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .bottom, relatedBy: .equal, toItem: profileImageView, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height , relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.titleString
            //thumbnailImageView.image = UIImage(named:(video?.thumbnailImageName)!)
            setupThumbnailImage()
            setupProfileImage()
//            if let profImage = video?.channel?.profileImageName {
//                profileImageView.image = UIImage(named:profImage)
//            }
            
            let formatNumber = NumberFormatter()
            formatNumber.numberStyle = .decimal
            let subTitleText = /*"\(video?.channel?.name ?? "") * \(formatNumber.string(from:(video?.numberOfViews)!) ?? "")*/" * 2 years ago"
            subTitleTextView.text = subTitleText
            if let title = video?.titleString {
                let size = CGSize(width: frame.width - 16 - 44 - 8, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
                let estimateedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)], context: nil)
                if estimateedRect.size.height > 20 {
                    titleTextHeightConstraint?.constant = 44
                } else {
                    titleTextHeightConstraint?.constant = 20
                }
            }
            
        }
    }
    func setupThumbnailImage() {
        if let thimageURL = video?.thumbnailImageName {
            //print(thimage)
            thumbnailImageView.loadImageViewByURL(url: thimageURL)
        }
    }
    
    func setupProfileImage() {
        if let profileImage = video?.channel?.profileImageName {
            //print(profileImage)
            profileImageView.loadImageViewByURL(url: profileImage)
        }
    }

    
    let thumbnailImageView:CustomUIImageView = {
        let imageView = CustomUIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "Problem_Lyric_VEVO")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return view
    }()
    
    let profileImageView: CustomUIImageView = {
        let view = CustomUIImageView()
        view.backgroundColor = UIColor.white
        view.image = UIImage(named: "regular_x2")
        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = ""//"Taylor Swift - Space Template "
        return label
    }()
    
    let subTitleTextView: UITextView = {
        let text = UITextView()
        text.text = "Taylor SwiftVEVO - 1,134,654,23 views - 2 years"
        text.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
        
    }()
}
