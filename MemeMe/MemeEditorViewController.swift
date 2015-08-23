//
//  ViewController.swift
//  MemeMe
//
//  Created by Ian Gristock on 17/08/2015.
//  Copyright (c) 2015 Ian Gristock. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UINavigationControllerDelegate {

    let memeTextAttributes = [
        NSStrokeWidthAttributeName: -3.0,
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSFontAttributeName: UIFont(name: "Impact", size: 40)!
        
    ]
    //MARK: top toolbar outlets
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    //MARK: bottom toolbar outlets
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumPickerButton: UIBarButtonItem!
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topTextInput: UITextField!{
        didSet {
            topTextInput.text = topTextDefaultValue
            topTextInput.defaultTextAttributes = memeTextAttributes
            topTextInput.textAlignment = .Center
            topTextInput.delegate = self
        }
    }
    
    @IBOutlet weak var bottomTextInput: UITextField!{
        didSet {
            bottomTextInput.text = bottomTextDefaultValue
            bottomTextInput.defaultTextAttributes = memeTextAttributes
            bottomTextInput.textAlignment = .Center
            bottomTextInput.delegate = self
        }
    }

    var memedImage : UIImage!
    let topTextDefaultValue = "TOP"
    let bottomTextDefaultValue = "BOTTOM"
    // i want to make sure once the user has emptied the default out that they can still use the words TOP and BOTTOM
    var topInputIsDirty = false
    var bottomInputIsDirty = false

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        shareButton.enabled = false
        memeImageView.contentMode = .ScaleAspectFit
    }

    //MARK: all actions from the view
    @IBAction func launchCamera(sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.editing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    
    @IBAction func resetMeme(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        memedImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems:[memedImage],applicationActivities:nil)
        presentViewController(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = {
            (s: String!, ok: Bool, items: [AnyObject]!, err:NSError!) -> Void in
            self.save()
            activityVC.dismissViewControllerAnimated(true, completion: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func launchAlbumPIcker(sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.editing = true
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: keyboard subscriber methods
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)

    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextInput.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func generateMemedImage() -> UIImage
    {
        //hide the toolbars
        topToolbar.hidden = true
        bottomToolbar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //show the toolbars
        topToolbar.hidden = false
        bottomToolbar.hidden = false
        return memedImage
    }
    
    func save() {
        var meme = Meme(topText: topTextInput.text, bottomText: bottomTextInput.text, image: memeImageView.image!, memedImage: memedImage)
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
}

extension MemeEditorViewController:  UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.memeImageView.image = image
            dismissViewControllerAnimated(true, completion: nil)
            shareButton.enabled = true
        }
    }
    
}

extension MemeEditorViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == topTextDefaultValue {
            if !topInputIsDirty {
                textField.text = ""
                topInputIsDirty = true
            }
        } else {
            if !bottomInputIsDirty {
                textField.text = ""
                bottomInputIsDirty = true
            }
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}