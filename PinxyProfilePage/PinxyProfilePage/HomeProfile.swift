//
//  HomeProfile.swift
//  PinxyProfilePage
//
//  Created by prakul agarwal on 15/04/24.
//

import UIKit

class HomeProfile: UIViewController {

    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.image2.layer.borderWidth = 1
        self.image2.layer.borderColor = UIColor.black.cgColor
        self.image2.layer.masksToBounds = false
        self.image2.layer.cornerRadius = image2.frame.size.height/2
        self.image2.clipsToBounds = true
        
        lblUserName.text = "\(username)"
        
    }
    

  

}
