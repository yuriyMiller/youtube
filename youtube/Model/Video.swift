//
//  Video.swift
//  youtube
//
//  Created by MacBookPro - Yuriy  on 2/23/18.
//  Copyright © 2018 com.mac.yuriy. All rights reserved.
//

import UIKit
class Video: NSObject {
    var thumbnailImageName: String?
    var titleString: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    var channel: Channel?
    
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
    
}
