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
    
    @IBAction func deleteMeme(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            if let foundIndex = find(appDelegate.memes, selectedMeme) {
                //remove the item at the found index
                appDelegate.memes.removeAtIndex(foundIndex)
                navigationController?.popViewControllerAnimated(true)
            }
    }
    @IBAction func editMeme(sender: AnyObject) {
        
        let memeEditorViewController = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        memeEditorViewController.meme = selectedMeme //payload
        presentViewController(memeEditorViewController, animated: true, completion: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let memedImage = selectedMeme.memedImage {
            detailsImageView.image = memedImage
        }
    }

}
