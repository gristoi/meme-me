//
//  MemeRepository.swift
//  MemeMe
//
//  Created by Ian Gristock on 13/09/2015.
//  Copyright (c) 2015 Ian Gristock. All rights reserved.
//

import Foundation

class MemeRepository {
    
    var memes: [Meme] = [Meme]()
    
    static let sharedInstance = MemeRepository()
    
    func getMemes() {
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths[0] as! String
        let dataFilePath = docsDir.stringByAppendingPathComponent("memes")
        if filemgr.fileExistsAtPath(dataFilePath) {
            memes = NSKeyedUnarchiver.unarchiveObjectWithFile(dataFilePath) as! [Meme]
        }

    }
    
    func persistMemes() {
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths[0] as! String
        let dataFilePath = docsDir.stringByAppendingPathComponent("memes")
        NSKeyedArchiver.archiveRootObject(memes, toFile: dataFilePath)
    }

}