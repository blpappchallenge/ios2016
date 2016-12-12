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

    private var navigator: SettingsNavigator!
    @IBOutlet weak var imagePicked: UIImageView!
    private let requestHandler = ServiceRequestHandler()
    private let serviceSerializer = ServiceSerializer()
    @IBOutlet weak var txtServiceName: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtServiceGeneration: UITextField!
    @IBOutlet weak var txtDeepLink: UITextField!
    @IBOutlet weak var optnServiceType: UISegmentedControl!
    var imageLink:String!

    var Services: [Service]? {
        didSet {
            
        }
    }
    
    
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
        let url = "https://api.imgur.com/3/image"
        // Get the picture from the connection
        let pictureURL = URL(string: url)!
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: pictureURL)
        let imageData = UIImagePNGRepresentation(imagePicked.image!)?.base64EncodedData(options: .lineLength64Characters)
        
        request.setValue("Client-ID c98baad70015b31", forHTTPHeaderField: "Authorization")
        //request.setValue(imageData, forHTTPHeaderField: "image")
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-type")
        request.httpBody = imageData
        request.httpMethod = "POST"
        
        let downloadTask = session.dataTask(with: request as URLRequest) {(data, response, error) in
            if error != nil {
                print(error)
            }
            else {
                if let res = response as? HTTPURLResponse {
                    let code = res.statusCode
                    print(code)
                    
                    do {
                        let response = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                        let responseData = response["data"] as! [String:Any]
                        self.imageLink = responseData["link"] as! String
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }
        }
        
        downloadTask.resume()
    }  
    
    

    
    @IBOutlet weak var Submit_Button: UIButton!
    @IBOutlet weak var ServiceName_Textbox: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let alert = UIAlertController(title: "Error", message: "Please make sure all fields are entered correctly.", preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        //alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: handleAlertCancel))
        //alert.addTextField(configurationHandler: {(textField: UITextField) in
            //textField.placeholder = "Field Title"})
        
        //Single or multiple taps to screen will do this
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        requestHandler.requestServices(completion: self.handleServiceResponse)
        self.navigator = SettingsNavigator(viewController: self)
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
    
    func validateInput() -> Bool {
        
        var isValid = true
       
        if txtDeepLink.text == "" {
            if optnServiceType.selectedSegmentIndex != 0 {
                isValid = false
            }
        }
        else if txtDescription.text == "" {
            isValid = false
        }
        else if txtServiceName.text == "" {
            isValid = false
        }
        else if txtServiceGeneration.text == "" {
            isValid = false
        }
        else if imageLink == nil {
            isValid = false
        }
        
        return isValid
    }

    @IBAction func Submit_Click(_ sender: Any) {
        
        // Validate input
        if validateInput() {
            
            createService()
        }
        else {
            showMessage()
        }
    }
    
    func createService() {
        
        if optnServiceType.titleForSegment(at: optnServiceType.selectedSegmentIndex) == "Native" {
            
            // Create generation.
            let generation = Generation(name: txtServiceGeneration.text!, clients: [Client]())
            var generations = [Generation]()
            generations.append(generation)
            
            
            var service = Service(name: txtServiceName.text!,
                                  description: txtServiceGeneration.text!,
                                  generations: generations,
                                  imageUrl: imageLink)
            service.deepLink = txtDeepLink.text!
            navigator.goToAddNewClient(nativeService: service, image: imagePicked.image!)
        }
        else {
            // Create generation.
            let generation = Generation(name: txtServiceGeneration.text!, clients: [Client]())
            var generations = [Generation]()
            generations.append(generation)
            
            
            var service = Service(name: txtServiceName.text!,
                                  description: txtServiceGeneration.text!,
                                  generations: generations,
                                  imageUrl: imageLink)

            navigator.goToAddNewClient(webService: service, image: imagePicked.image!)
        }
    }
    
    func handleServiceResponse(services:[Service]?, error:Error?) {
        Services = services
    }
    @IBAction func ServiceType_Changed(_ sender: Any) {
        if optnServiceType.selectedSegmentIndex == 0 {
            txtDeepLink.isHidden = true
        }
        else {
            txtDeepLink.isHidden = false
        }
    }
    
}
