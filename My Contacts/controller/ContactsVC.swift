//
//  ViewController.swift
//  My Contacts
//
//  Created by Shafeer Puthalan on 25/06/18.
//  Copyright © 2018 Shafeer Puthalan. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
  
    var array : [String] = Array()
    var searchedList : [String] = Array()

    @IBOutlet var searchBar: UITextField!
    @IBOutlet var contactsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.roundedCorner(cornerRadius : 15)
        searchBar.delegate = self
        
        for str in array{
            searchedList.append(str)
        }
        
        searchBar.addTarget(self, action: #selector(self.searchRecords(textField:)), for: .editingChanged)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
    
    @objc func searchRecords(textField:UITextField){
        self.array.removeAll()
        if textField.text?.count != 0 {
            for contact in searchedList {
                if let contactToSeatch = textField.text {
                    let range = contact.lowercased().range(of: contactToSeatch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil{
                        self.array.append(contact)
                    }
                }
            }
        }
        else {
            for str in searchedList{
                array.append(str)
            }
        }
        contactsTable.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact-cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    


}

