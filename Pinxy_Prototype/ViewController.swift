//
//  ViewController.swift
//  Pinxy_Prototype
//
//  Created by Ananaya on 02/04/24.
//

import UIKit

class ViewController: UIViewController {
    var eventName: String?
        var selectedFriends: [String] = ["Friend 1", "Friend 2", "Friend 3"]
    @IBOutlet weak var eventNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    }

