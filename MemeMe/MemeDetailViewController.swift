//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Ian Gristock on 23/08/2015.
//  Copyright (c) 2015 Ian Gristock. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    var selectedMeme: Meme!
    @IBOutlet weak var detailsImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let memedImage = selectedMeme.memedImage {
            detailsImageView.image = memedImage
        }
    }

}
