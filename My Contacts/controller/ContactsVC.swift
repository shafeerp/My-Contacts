//
//  ViewController.swift
//  My Contacts
//
//  Created by Shafeer Puthalan on 25/06/18.
//  Copyright © 2018 Shafeer Puthalan. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
  
    var dbHelper = DBHelper()
    var contacts = [Contacts]()
    var filteredContacts = [Contacts]()

    @IBOutlet var searchBar: UITextField!
    @IBOutlet var contactsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactsTable.rowHeight = 70
        self.contactsTable.separatorStyle = .none
        searchBar.roundedCorner(cornerRadius : 15)
        searchBar.delegate = self
        searchBar.addTarget(self, action: #selector(self.searchRecords(textField:)), for: .editingChanged)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        contacts.removeAll()
        filteredContacts.removeAll()
        getContacts()
        for contact in contacts{
            filteredContacts.append(contact)
        }
    }
    
    @objc func searchRecords(textField:UITextField){
        self.contacts.removeAll()
        if textField.text?.count != 0 {
            for contact in filteredContacts{
                if let contactToSearch = textField.text{
                    let range = contact.firstname.lowercased().range(of: contactToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil{
                        self.contacts.append(contact)
                    }
                }
            }
        }
        else {
            for contact in filteredContacts{
                contacts.append(contact)
            }
        }
        contactsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact-cell", for: indexPath) as! ContactsCell
        cell.contactIcon.image = Common.decodeToImage(base64String: contacts[indexPath.row].image)
        cell.contactName?.text = "\(contacts[indexPath.row].firstname) \(contacts[indexPath.row].secondname)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            dbHelper.deleteEntryFromContactTable(ID: self.contacts[indexPath.row].id)
            self.contacts.remove(at: indexPath.row)
            contactsTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    func getContacts(){
        contacts.removeAll()
        contacts = dbHelper.getContactTableDetails()
        if contacts.isEmpty{
            print("Empty")
            Common.showEmptyAlert(title: "No Contact", message: "Please add contact", view: self)
        }
        else {
            //show contacts
            contactsTable.reloadData()
        }
    }
    


}

