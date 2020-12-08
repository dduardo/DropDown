//
//  FilterViewModel.swift
//  DropDown
//
//  Created by Carlos Eduardo Santiago on 07/12/20.
//  Copyright © 2020 Carlos Eduardo Santiago. All rights reserved.
//

import Foundation

protocol FilterViewModelProtocol {
    var itens: [ModelProtocol] { get }
    var itensFiltred: [ModelProtocol] { get }
    var tagItens: [ModelProtocol] { get }
    var dataSource: FilterViewModelDataSource? { get set }

    func filter(text: String)
    func loadingItems()
    func addTagFilter(item: ModelProtocol)
    func removeTagFilter(item: ModelProtocol)
}

protocol FilterViewModelDataSource {
    func loadingItems(completion: (_ result: [ModelProtocol]) -> Void)
}

class FilterViewModel: FilterViewModelProtocol {

    var itens: [ModelProtocol] = []
    lazy var itensFiltred: [ModelProtocol]  = {
      return itens
    }()

    var tagItens: [ModelProtocol] = []
    var dataSource: FilterViewModelDataSource?

    func loadingItems() {
        dataSource?.loadingItems { [weak self] result in
            guard let self = self else { return }
            self.itens = result
        }
    }

    func filter(text: String) {
        if !text.isEmpty {
            itens = itensFiltred.filter { $0.name.lowercased().contains(text.lowercased()) }
        } else {
            itens = itensFiltred
        }
    }

    func addTagFilter(item: ModelProtocol) {
        if !tagItens.contains(where: {$0.id == item.id}) {
            tagItens.append(item)
        }
    }

    func removeTagFilter(item: ModelProtocol) {
        if let indexOf = tagItens.firstIndex(where: { $0.id == item.id }) {
            tagItens.remove(at: indexOf)
        }
    }
}
