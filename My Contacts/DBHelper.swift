//
//  DBHelper.swift
//  My Contacts
//
//  Created by Shafeer Puthalan on 26/06/18.
//  Copyright © 2018 Shafeer Puthalan. All rights reserved.
//

import Foundation
import SQLite
class DBHelper {
    
    let db = try! Connection("\(Common.path)/contacts.sqlite3")
    let contactsDB = Table("contacts")
    var contacts = [Contacts]()
    let id = Expression<Int64>("id")
    let firstName = Expression<String>("firstName")
    let secondName = Expression<String>("secondName")
    let email = Expression<String>("email")
    let country = Expression<String>("country")
    let mobileNumber = Expression<String>("mobileNumnber")
    let imageData = Expression<String>("imageData")
    
    init() {
        
        
        try! db.run(contactsDB.create(ifNotExists: true) { table in
            table.column(id,primaryKey:.autoincrement)
            table.column(firstName)
            table.column(secondName)
            table.column(email,unique:true)
            table.column(country)
            table.column(mobileNumber)
            table.column(imageData)
        })
    }
    
    public func insertIntoContactTabel(firstname : String,secondname: String,mailId: String,cont:String,number:String,image:String){
        
        do{
            let rowId = try db.run(contactsDB.insert(firstName <- firstname,secondName <- secondname,email <- mailId,country <- cont,mobileNumber <- number , imageData <- image))
            print("inserted at \(rowId)")
        }
        catch{
            print("Insertion Failed")
        }
    }
    public func getContactTableDetails() -> [Contacts]{
        for contact in try! db.prepare(contactsDB) {
            contacts.append(Contacts(firstname: contact[firstName], secondname: contact[secondName], email: contact[email], country: contact[country], mobileNumber: contact[mobileNumber], image: contact[imageData]))
        }
        return contacts
    }
    
    
    
}

