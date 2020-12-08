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

    private var viewModel: FilterViewModelProtocol = FilterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.dataSource = self

        // Do any additional setup after loading the view.
//        testeView.mainLabel.text = "bkakdsad"
    }

}

extension ViewController: DropDownViewProtocol {
    func loadingDescription(completion: (String) -> Void) {
        completion("passou")
    }

    func didTouched() {
        let popUp = FilterViewController(viewModel: viewModel)
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.modalTransitionStyle = .crossDissolve

        self.present(popUp, animated: true, completion: nil)
    }
}

extension ViewController: FilterViewModelDataSource {
    func loadingItems(completion: ([ModelProtocol]) -> Void) {
        completion([Hospital(id: "0", name: "hospital1", address: "", sulfHosp: ""),
                    Hospital(id: "1", name: "hospital2", address: "", sulfHosp: ""),
                    Hospital(id: "2", name: "hospital3", address: "", sulfHosp: ""),
                    Hospital(id: "3", name: "hospital4", address: "", sulfHosp: ""),
                    Hospital(id: "4", name: "Mayo Clinic (EUA) ...", address: "", sulfHosp: ""),
                    Hospital(id: "5", name: "Cleveland Clinic (EUA) ...", address: "", sulfHosp: ""),
                    Hospital(id: "6", name: "Singapore General Hospital (Cingapura) ...", address: "", sulfHosp:""),
                    Hospital(id: "7", name: "Johns Hopkins Hospital (EUA)", address: "", sulfHosp: ""),
                    Hospital(id: "8", name: "Charité (Alemanha) ...", address:"", sulfHosp:""),
                    Hospital(id: "9", name: "Massachussetts General Hospital (EUA)", address: "", sulfHosp: ""),
                    Hospital(id: "10", name: "Toronto General Hospital (Canadá)", address: "", sulfHosp: ""),
                    Hospital(id: "11", name: "The University of Tokyo Hospital (Japão)", address: "", sulfHosp: "")])
    }
}
