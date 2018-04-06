//
//  ViewController.swift
//  youtube
//
//  Created by MacBookPro - Yuriy  on 2/7/18.
//  Copyright © 2018 com.mac.yuriy. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    let videos: [Video] = {
//
//        let kennyChannel = Channel()
//        kennyChannel.name = "Kenny Channel"
//        kennyChannel.profileImageName = "regular_x2"
//
//        let video1 = Video()
//        video1.thumbnailImageName = "taylor_swift_blank_space"
//        video1.titleString = "Taylor Swift - Space Template "
//        video1.channel = kennyChannel
//        video1.numberOfViews = 23348675
//
//        let video2 = Video()
//        video2.thumbnailImageName = "Problem_Lyric_VEVO"
//        video2.titleString = "Taylor Swift - Space Template 2 - Views : Many to many "
//        video2.channel = kennyChannel
//        video2.numberOfViews = 234456234
//
//        return[video1, video2]
//    }()
    var videos: [Video]?
    
    func fetchVideosFromJSON() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if (error != nil) {
                print(error as Any)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [.mutableContainers])
                print(json)
                self.videos = [Video]()
                
                for dictionary in json as! [[String : AnyObject]] {
                    let video = Video()
                    video.titleString = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String : AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    self.videos?.append(video)
                    
                    
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        let navBarLable = UILabel()
        navBarLable.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height)
        navBarLable.font = UIFont.systemFont(ofSize: 20)
        navBarLable.text = "HOME"
        navBarLable.textColor = UIColor.white
        navigationItem.titleView = navBarLable
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0 )
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellID")
        fetchVideosFromJSON()
        setupMenuBar()
        setupNavBarButtons()
        
    }
    
    func setupNavBarButtons()  {
        let searchImage:UIImage = UIImage(named:"search_icon")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let searchButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage:UIImage = UIImage(named:"nav_more_icon")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton,searchButton]
    }
    lazy var settingLauncher: SettingsLauncher = {
       let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func handleMore() {
        //Show menu
        settingLauncher.showSettings()
    }
    
    func showControllerForSettings(setting: Setting) {
        let dummyVC = UIViewController()
        dummyVC.navigationItem.title = setting.name.rawValue
        dummyVC.view.backgroundColor = UIColor()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.pushViewController(dummyVC, animated: false)
    }
    
    let blackView = UIView()
    
    @objc func handleSearch() {
        print("handleSearch")
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstrainsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = videos?.count {
//            return count
//        }
        
        return videos?.count ?? 0;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.bounds.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



