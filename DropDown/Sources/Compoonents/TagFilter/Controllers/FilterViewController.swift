//
//  FilterViewController.swift
//  DropDown
//
//  Created by Carlos Eduardo Santiago on 07/12/20.
//  Copyright © 2020 Carlos Eduardo Santiago. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet private weak var filterTextField: UITextField! {
        didSet {
            filterTextField.delegate = self
        }
    }

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    @IBOutlet private weak var selectionButton: UIButton!
    @IBOutlet private weak var closeButton: UIButton!

    // MARK: - Constants

    private enum Constants {
        static let kConstantNibNameIdentifier = "FilterViewController"
        static let kConstantTableViewCellIdentifier = "FilterTableViewCell"
        static let kConstantCollectionViewCellIdentifier = "FilterTagCell"

    }

    var viewModel: FilterViewModelProtocol?

    required init(viewModel: FilterViewModelProtocol?) {
        super.init(nibName: Constants.kConstantNibNameIdentifier,
                   bundle: Bundle.main)
        self.viewModel = viewModel

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel?.loadingItems()
    }

    private func setup() {
        setupView()
    }

    private func setupView() {
        collectionView?.register(UINib(nibName: Constants.kConstantCollectionViewCellIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.kConstantCollectionViewCellIdentifier)
        tableView?.register(UINib(nibName: Constants.kConstantTableViewCellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: Constants.kConstantTableViewCellIdentifier)        
    }

    @IBAction private func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let _ = textField.text{
            let text = textField.text! as NSString
            print(text)
            let fullText = text.replacingCharacters(in: range, with: string)
            print(fullText)
            let wordCount = fullText.components(separatedBy: " ").count
            print(wordCount)

            viewModel?.filter(text: fullText)
            tableView.reloadData()
        }
        return true
    }
}

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.tagItens.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterTagCell", for: indexPath) as? FilterTagCell,
        let item = viewModel?.tagItens[indexPath.row] else { return UICollectionViewCell() }
        cell.delegate = self
        cell.setupCell(model: item)

        return cell
    }
}

extension FilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

extension FilterViewController: UITableViewDelegate,  UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itens.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kConstantTableViewCellIdentifier) as? FilterTableViewCell,
            let item = viewModel?.itens[indexPath.row] else { return UITableViewCell() }
        cell.setup(model: item)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = viewModel?.itens[indexPath.row] {
            viewModel?.addTagFilter(item: item)
            collectionView.reloadData()
        }
    }
}

extension FilterViewController: TagCellDelegate {
    func didTapButton(_ item: ModelProtocol) {
        viewModel?.removeTagFilter(item: item)
        collectionView.reloadData()
    }
}
