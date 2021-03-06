//
//  Controller_AddNewClient.swift
//  ISDA
//
//  Created by Jason  on 12/6/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import Foundation

class Controller_AddNewClient: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var selectedService: Service? {
        didSet {
            serviceLabel?.text = selectedService?.name
        }
    }
    
    @IBOutlet weak var serviceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func selectServicePressed(_ sender: Any) {

        
    }
    
    
    @IBAction func didPressSelectService(_ sender: Any) {
        let serviceViewController = SettingsViewControllerFactory().makeSelectServiceViewController() { service in
            self.selectedService = service
        }
        self.navigationController?.pushViewController(serviceViewController, animated: true)
    }
    
    
    @IBAction func didPressSubmit(_ sender: Any) {
        if let firstService = App.services?.first {
            handleServiceSelected(service: firstService)
        }
    }
    
    func handleServiceSelected(service:Service) {
        let id = idTextField.text ?? "default id"
        let name = nameTextField.text ?? "default name"
        let username = usernameTextField.text ?? "default username"
        let password = passwordTextField.text ?? "default password"
        let url = urlTextField.text ?? "default url"
        addNewClient(id: id,
                     url: url,
                     name: name,
                     username: username,
                     password: password,
                     generationName: url,
                     type:"")
    }
    
    func addNewClient(id: String,
                      url: String,
                      name:String,
                      username: String,
                      password:String,
                      generationName:String,
                      type:String) {
        
        if let service = selectedService {
            service.addClient(id: id,
                              url: url,
                              name: name,
                              username: username,
                              password: password,
                              generationName: generationName,
                              type:type)
        }
    }
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
    
}
