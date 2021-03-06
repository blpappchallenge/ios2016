//
//  Controller_AddNewService.swift
//  ISDA
//
//  Created by Zack on 11/29/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class Controller_AddNewService: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var imagePicked: UIImageView!
    
    
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info["UIImagePickerControllerEditedImage"] as? UIImage
        imagePicked.image = image
        self.dismiss(animated: true, completion: nil);
    }  
    
    

    
    @IBOutlet weak var Submit_Button: UIButton!
    @IBOutlet weak var ServiceName_Textbox: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let alert = UIAlertController(title: "New Field", message: "Enter New Field Title", preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler: handleAlertSubmit))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: handleAlertCancel))
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            textField.placeholder = "Field Title"})
        
        //Single or multiple taps to screen will do this
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    //When screen is tapped after typing in keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configurationTextField(textField: UITextField)
    {
        
    }
    
    func showMessage() {
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleAlertSubmit(alertView: UIAlertAction!)
    {
        let lastField = getLastTextField()
        let newField = UITextField()
        
        newField.frame = lastField.frame
        newField.frame.origin.y += 57
        newField.backgroundColor = lastField.backgroundColor
        newField.borderStyle = lastField.borderStyle
        newField.font = lastField.font
        newField.placeholder = alert.textFields![0].text
        
        scrollView.addSubview(newField)
    }
    
    func handleAlertCancel(alertView: UIAlertAction!)
    {
        
    }
    
    func getLastTextField() -> UITextField
    {
        var lastField = UITextField()
        
        for view in scrollView.subviews as [UIView] {
            
            if let textField = view as? UITextField {
                
                lastField = textField
            }
        }
        
        return lastField
    }
    
    
    @IBAction func AddNewField_Click(_ sender: Any) {
        showMessage()
    }

    @IBAction func Submit_Click(_ sender: Any) {
        
       

        
    }
    
}
