//
//  MemeCollectionView.swift
//  MemeMe
//
//  Created by Ian Gristock on 23/08/2015.
//  Copyright (c) 2015 Ian Gristock. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {

    
    @IBOutlet weak var flowLayout:UICollectionViewFlowLayout!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var memes: [Meme] = [Meme]()
    let cellIdentifier = "MemeCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let widthDimension = (view.frame.size.width - (2 * space)) / 3.0
        let heightDimension = (view.frame.size.height - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(widthDimension, heightDimension)
        
        memes = appDelegate.memes
        collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        let meme = memes[indexPath.item]
        cell.backgroundView = UIImageView(image: meme.memedImage)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let memeDetailVC = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailVC.selectedMeme = memes[indexPath.item]
        navigationController!.pushViewController(memeDetailVC, animated: true)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
}
