//
//  EventsViewController.swift
//  Pinxy
//
//  Created by Ananaya on 14/04/24.
//

import UIKit

class EventsViewController: UIViewController {
    var eventName: String?
    var selectedFriends: [String] = ["Friend 1", "Friend 2", "Friend 3"]

    @IBOutlet weak var dataStoreStack: UIStackView!
    
    @IBOutlet weak var eventDetailsStack: UIStackView!
    
    @IBOutlet weak var eventNameTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var LabelSection2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStoreStack.layer.cornerRadius = 8 // Change the value to your desired corner radius
        eventDetailsStack.layer.cornerRadius = 8 
        LabelSection2.padding(<#T##SwiftUI.EdgeInsets#>)
        // Do any additional setup after loading the view.
        // datePicker?
    }
    
    @IBAction func EventName(_ sender: Any) {
        eventName = eventNameTextField.text
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowCamera" {
         if let cameraVC = segue.destination as? CameraViewController {
             cameraVC.eventName = eventName
                cameraVC.selectedFriends = selectedFriends
           }
            }
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  //  @IBAction func unwindtoEvent(segue:UIStoryboardSegue){
  //      <#code#>
  //  }
}
