//
//  Controller_LaunchOptions.swift
//  Test this
//
//  Created by Zack on 10/28/16.
//  Copyright © 2016 Zack. All rights reserved.
//

import UIKit

class Controller_LaunchOptions: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var clientLogo: UIImageView!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var btnLaunch: UIButton!
    @IBOutlet weak var optnBranch: UISegmentedControl!
    @IBOutlet weak var optnAccountType: UISegmentedControl!
    @IBOutlet weak var optnLoginMethod: UISegmentedControl!
    var service: Service!
    
    @IBOutlet weak var lstClients: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lstClients.delegate = self
        lstClients.dataSource = self

        // Show the client logo.
        lblClientName.text = service.Name.uppercased()
        lblServiceName.text = "\(service.Gen)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Send the selected information to the web view page to display to the user.
//        if (segue.identifier == "webViewSegue") {
//            let svc = segue.destination as! Controller_WebView
//            let client =
//            
//            svc.branch = optnBranch.titleForSegment(at: optnBranch.selectedSegmentIndex)!.lowercased()
//            svc.accountType = optnAccountType.titleForSegment(at: optnAccountType.selectedSegmentIndex)!.lowercased().replacingOccurrences(of: " ", with: "")
//            svc.userName = service.testAccounts[lstTestAccounts.selectedRow(inComponent: 0)].userName
//            svc.password = service.testAccounts[lstTestAccounts.selectedRow(inComponent: 0)].password
//            svc.url = service.serviceURL
//            svc.loginMethod = optnLoginMethod.titleForSegment(at: optnLoginMethod.selectedSegmentIndex)!
//        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return service.Clients.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return service.Clients[row].Name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Test account at index #\(row)! has been selected.")
    }
    
    @IBAction func optnLoginMethod_Changed(_ sender: UISegmentedControl) {
        if (optnLoginMethod.selectedSegmentIndex == 1)
        {
            lstClients.isHidden = true
        }
        else
        {
            lstClients.isHidden = false
        }
    }
    
    @IBAction func btnLaunch_Click(_ sender: UIButton) {
        //performSegue(withIdentifier: "webViewSegue", sender: self)
        let defaults = UserDefaults.init(suiteName: "group.com.synchrony.test")
        defaults?.set("gapdc8364", forKey: "username")
        defaults?.set("Test12Test", forKey: "password")
    }
}
