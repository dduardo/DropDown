//
//  DropDownView.swift
//  DropDown
//
//  Created by Carlos Eduardo Santiago on 04/12/20.
//  Copyright © 2020 Carlos Eduardo Santiago. All rights reserved.
//

import UIKit

protocol DropDownViewProtocol: class {
    func loadingDescription(completion: (_ result: String) -> Void)
    func didTouched()
}

class DropDownView: UIView {

    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .red
            let tap = UITapGestureRecognizer(target: self, action: #selector(openDrop))
            contentView.addGestureRecognizer(tap)
        }
    }

    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = "asdasdsadasdsad"
            fetchDescription()
        }
    }

    @IBOutlet weak var iconImage: UIImageView!

    var delegate: DropDownViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("DropDownView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    @objc private func openDrop() {
        delegate?.didTouched()

        fetchDescription()
    }

    private func fetchDescription() {
        delegate?.loadingDescription { [weak self] result in
            guard let self = self else { return }
            self.descriptionLabel.text = result
        }
    }
}
