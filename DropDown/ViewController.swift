//
//  ViewController.swift
//  DropDown
//
//  Created by Carlos Eduardo Santiago on 04/12/20.
//  Copyright © 2020 Carlos Eduardo Santiago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drop: DropDownView! {
        didSet {
            drop.delegate = self
        }
    }

//    @IBOutlet weak var testeView: TesteView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        testeView.mainLabel.text = "bkakdsad"
    }

}

extension ViewController: DropDownViewProtocol {
    func loadingDescription(completion: (String) -> Void) {
        completion("passou")
    }

    func didTouched() {
        let secondViewController = SecondViewController()
        self.present(secondViewController, animated: true, completion: nil)
    }

}
