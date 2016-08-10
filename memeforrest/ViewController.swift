//
//  ViewController.swift
//  memeforrest
//
//  Created by Forrest Ching on 8/10/16.
//  Copyright © 2016 Urban Forrest. All rights reserved.
//

import UIKit

//
//  ViewController.swift
//  MemeMeForrest
//
//  Created by Forrest Ching on 8/8/16.
//  Copyright © 2016 Urban Forrest. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    /** VARIABLES **/
    
    //Meme
    @IBOutlet weak var memeView: UIImageView!
    @IBOutlet weak var memeTopText: UITextField!
    @IBOutlet weak var memeBottomText: UITextField!
    
    //Tab Bar
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    //Image Picker
    let imagePicker = UIImagePickerController()
    
    /** OVERRIDE FUNCTIONS **/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Meme
        memeTopText.delegate = self
        memeBottomText.delegate = self
        
        setMemeStyle(memeTopText)
        setMemeStyle(memeBottomText)
        
        //Tab Bar
        
        //Keyboard
        
        //Image Picker
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Meme
        
        //Tab Bar
        
        //Keyboard
        subscribeToKeyboardNotifications()
        
        //Image Picker
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Meme
        
        //Tab Bar
        
        //Keyboard
        unsubscribeFromKeyboardNotifications()
        
        //Image Picker
    }
    
    /** HELPER FUNCTIONS **/
    
    //Meme
    func setMemeStyle(textField: UITextField) -> Void {
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(
                name : "HelveticaNeue-CondensedBlack" ,
                size : 25
                )!,
            NSStrokeWidthAttributeName : -1.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = NSTextAlignment.Center
    }
    
    //Tab Bar
    
    //Keyboard
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self,name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func keyboardWillShow(notification: NSNotification) -> Void{
        if memeBottomText.isFirstResponder() {
            view.frame.origin.y = -1 * getKeyboardHeight(notification)
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
    
    //Image Picker
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum (sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //User chose an image
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeView.contentMode = .ScaleAspectFit
            memeView.image = image
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_picker: UIImagePickerController) {
        
        //User canceled out of the Picker
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}




