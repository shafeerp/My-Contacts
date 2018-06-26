//
//  Contacts.swift
//  SQL
//
//  Created by Shafeer Puthalan on 26/06/18.
//  Copyright © 2018 Shafeer Puthalan. All rights reserved.
//

import Foundation
class Contacts {
    
    let firstname : String
    let secondname: String
    let email : String
    let country:String
    let mobileNumber:String
    let image:String
    
    init(firstname : String,secondname: String,email : String,country:String,mobileNumber:String,image:String) {
        self.firstname = firstname
        self.secondname = secondname
        self.email = email
        self.country = country
        self.mobileNumber = mobileNumber
        self.image = image
    }
    
}
