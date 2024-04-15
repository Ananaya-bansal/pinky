//
//  ContactViewController.swift
//  Pinxy
//
//  Created by Ananaya on 14/04/24.
//

import UIKit
import Contacts
class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tablesView: UITableView!
    
    var contactStore = CNContactStore()
    var contacts = [ContactStruct]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablesView.delegate = self
        tablesView.dataSource = self
        
        contactStore.requestAccess(for: .contacts) { (success, error) in
            if success {
                print("Authorization Successfull")
            }
        }
        
        fetchContacts()
        
        // Set table view background color
        view.backgroundColor = .black
        tablesView.backgroundColor = .black
        
        // Set table view separator color
        tablesView.separatorColor = .gray
        
    }
    // Set background color of the view and table view to black
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = .black
        let contactToDisplay = contacts[indexPath.row]
        cell.textLabel?.text = contactToDisplay.givenName + " " + contactToDisplay.familyName
        cell.detailTextLabel?.text = contactToDisplay.number
        // Set text color to white
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
//        // Add alphabets on the right side for easy navigation
//        if let alphabet = contactToDisplay.givenName.first?.uppercased() {
//            // Create a button for the alphabet
//            let button = UIButton(type: .system)
//            button.setTitle(alphabet, for: .normal)
//            button.setTitleColor(.white, for: .normal)
//            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//            button.backgroundColor = .clear
//            button.layer.borderWidth = 1
//            button.layer.borderColor = UIColor.white.cgColor
//            button.layer.cornerRadius = 5
//            button.clipsToBounds = true
//            
//            // Add target for the button tap event
//            button.addTarget(self, action: #selector(handleAlphabetButtonTap), for: .touchUpInside)
//            
//            // Set the button as the accessory view of the cell
//            cell.accessoryView = button
//        }
        
        return cell
    }
    
    func fetchContacts() {
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        try! contactStore.enumerateContacts(with: request) { (contact, stoppingPointer) in
            let name = contact.givenName
            let familyName = contact.familyName
            let number = contact.phoneNumbers.first?.value.stringValue
            
            let contactToAppend = ContactStruct(givenName: name, familyName: familyName, number: number!)
            
            self.contacts.append(contactToAppend)
        }
        tablesView.reloadData()
    }
    
    @objc func handleAlphabetButtonTap(_ sender: UIButton) {
        // Get the alphabet from the button's current title
        if let alphabet = sender.currentTitle {
            // Find the index of the first contact whose first name starts with the tapped alphabet
            if let index = contacts.firstIndex(where: { $0.givenName.first?.uppercased() == alphabet }) {
                // Create an index path for the row
                let indexPath = IndexPath(row: index, section: 0)
                
                // Scroll to the corresponding row in the table view
                tablesView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }

  //  @IBAction func doneButtonPressed(_ sender: Any) {
   //     performSegue(withIdentifier: "unwindtoEvent", sender: self)
  //  }
}
