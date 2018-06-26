//
//  Common.swift
//  My Contacts
//
//  Created by Shafeer Puthalan on 25/06/18.
//  Copyright © 2018 Shafeer Puthalan. All rights reserved.
//

import Foundation
import UIKit

class Common{
    
    public static let COUNTRY_URL = "https://restcountries.eu/rest/v1/all"
}

extension UITextField{
    func roundedCorner(cornerRadius : CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
extension UIImageView{
    func makeRounded(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.layer.frame.width/2
    }
}
extension UIButton{
    func roundedCorner(cornerRadius : CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
