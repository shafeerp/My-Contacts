//
//  ContactsCell.swift
//  My Contacts
//
//  Created by Shafeer Puthalan on 28/06/18.
//  Copyright © 2018 Shafeer Puthalan. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {

    @IBOutlet var contactName: UILabel!
    @IBOutlet var contactIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        contactIcon.makeRounded()
    }

}
