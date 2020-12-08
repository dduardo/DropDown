//
//  FilterTagCell.swift
//  DropDown
//
//  Created by Carlos Eduardo Santiago on 07/12/20.
//  Copyright © 2020 Carlos Eduardo Santiago. All rights reserved.
//

import UIKit

protocol TagCellDelegate {
    func didTapButton(_ item: ModelProtocol)
}

class FilterTagCell: UICollectionViewCell {

    @IBOutlet private weak var tagDescriptionLabel: UILabel!

    @IBOutlet private weak var removeTagButton: UIButton!

    @IBOutlet private  weak var tagNameMaxWidthConstraint: NSLayoutConstraint!

    var delegate: TagCellDelegate?
    private var modelProtocol: ModelProtocol? = nil
    // MARK: - Setup methods

    func setupCell(model: ModelProtocol) {
        modelProtocol = model
        tagDescriptionLabel.text = model.name
    }


    override func awakeFromNib() {
    self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    self.tagDescriptionLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    self.layer.cornerRadius = 4
        self.tagNameMaxWidthConstraint.constant = UIScreen.main.bounds.width - 8 * 2 - 8 * 2 }

    @IBAction private func removeTag(_ sender: Any) {
        if let model = modelProtocol {
            delegate?.didTapButton(model)
        }
    }
}
