//
//  Meme.swift
//  MemeMe
//
//  Created by Ian Gristock on 19/08/2015.
//  Copyright (c) 2015 Ian Gristock. All rights reserved.
//

import Foundation
import UIKit

// chose to use class instead of struct as i will be updating the object by reference
class Meme: NSObject {
    
    var topText : String!
    var bottomText: String!
    var image: UIImage!
    var memedImage: UIImage!
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}