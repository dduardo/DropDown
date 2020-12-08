//
//  FilterTableViewCell.swift
//  DropDown
//
//  Created by Carlos Eduardo Santiago on 07/12/20.
//  Copyright © 2020 Carlos Eduardo Santiago. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(model: ModelProtocol) {
        self.isUserInteractionEnabled = true
        selectionStyle = .none
        
        descriptionLabel?.text = model.name
    }
}
