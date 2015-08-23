//
//  Meme.swift
//  MemeMe
//
//  Created by Ian Gristock on 19/08/2015.
//  Copyright (c) 2015 Ian Gristock. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject {
    
    var topText : String?
    var bottomText: String?
    var image: UIImage?
    var memedImage: UIImage?
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        self.bottomText = bottomText
        self.topText = topText
        self.image = image
        self.memedImage = memedImage
    }
}