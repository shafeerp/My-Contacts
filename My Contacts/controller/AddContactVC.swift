//
//  AddContactVC.swift
//  My Contacts
//
//  Created by Shafeer Puthalan on 26/06/18.
//  Copyright © 2018 Shafeer Puthalan. All rights reserved.
//

import UIKit

struct Countries : Codable{
    var name : String
    var callingCodes : [String]?
}

class AddContactVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
   //TextField
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var countryDropDown: DropDown!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var secondNameTextField: UITextField!
    @IBOutlet var mailIDTextField: UITextField!
    
    var dbHelper = DBHelper()
    var countryNames : [String] = Array()
    //ImageView
    @IBOutlet var contactIcon: UIImageView!
    
    //Button
    @IBOutlet var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.alpha = 0
        saveButton.alpha = 0
        contactIcon.makeRounded()
        saveButton.roundedCorner(cornerRadius: 15)
        getCountryDetails()
    }
    

    @IBAction func addImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        contactIcon.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonClick(_ sender: Any) {
        
        if firstNameTextField.text == "" {
            firstNameTextField.shake()
        }
        else if secondNameTextField.text == ""{
            secondNameTextField.shake()
        }
        else if mailIDTextField.text == ""{
            mailIDTextField.shake()
        }
        else if countryDropDown.text == ""{
            countryDropDown.shake()
        }
        else if numberTextField.text == ""{
            numberTextField.shake()
        }
        else {
             dbHelper.insertIntoContactTabel(firstname: firstNameTextField.text!, secondname: secondNameTextField.text!, mailId: mailIDTextField.text!, cont: countryDropDown.text!, number: numberTextField.text!, image: "")
            Common.showAlert(title: "Saved", message: "Contact Successfully Saved", view: self)
        }
    }
    
    
    
    func getCountryDetails(){
        var countryCode = [String]()
        let urlRequest = URLRequest(url:URL(string: Common.COUNTRY_URL)!)
        _ = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let contryData = try! JSONDecoder().decode([Countries].self, from: data!)
            for i in contryData{
                self.countryNames.append(i.name)
                if(i.callingCodes?.isEmpty)!{
                    countryCode.append("0")
                }
                else {
                    countryCode.append(i.callingCodes![0])
                }
            }
            self.countryDropDown.optionIds = countryCode
            self.countryDropDown.optionArray = self.countryNames
            self.countryDropDown.didSelect(completion: { (selectedText, index, id) in
                let label = UILabel()
                label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                label.text = "+\(id)"
                label.frame = CGRect(x:0,y:0,width:label.intrinsicContentSize.width,height:label.intrinsicContentSize.width)
                self.numberTextField.leftViewMode = .always
                self.numberTextField.leftView = label
                self.countryDropDown.text = selectedText
                
            })
        }.resume()
        
        self.countryDropDown.listDidDisappear {
            UIView.animate(withDuration: 1, animations: {
                self.numberTextField.alpha = 1
                self.saveButton.alpha = 1
            })
        }
        self.countryDropDown.listWillAppear {
            self.numberTextField.alpha = 0
            self.saveButton.alpha = 0
        }
       
    }
    
    
}
