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
    
    public static let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
        ).first!
    public static let COUNTRY_URL = "https://restcountries.eu/rest/v1/all"
    
    
    public static func showAlert(title: String ,message : String,view:UIViewController){
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (alert) in
            view.navigationController?.popViewController(animated: true)
        }))
        view.present(alert, animated: true, completion: nil)
        
    }

    public static func showEmptyAlert(title: String ,message : String,view:UIViewController){
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Add Contact", style: .default, handler: { (alert) in
            let addContact = view.storyboard?.instantiateViewController(withIdentifier:"AddContactVC") as! AddContactVC
            view.navigationController?.pushViewController(addContact, animated: true)
        }))
        view.present(alert, animated: true, completion: nil)
    }
    
    public static func encodeToString64(image:UIImage) -> String{
        let imageData : NSData = UIImagePNGRepresentation(image)! as NSData
        let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
        return base64String
    }
    public static func decodeToImage(base64String : String) -> UIImage{
        let imageData : Data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
        
    }
}

extension UITextField{
    func roundedCorner(cornerRadius : CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        self.layer.borderColor = UIColor.red.cgColor
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
        animation.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
        layer.add(animation, forKey: "position")
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
