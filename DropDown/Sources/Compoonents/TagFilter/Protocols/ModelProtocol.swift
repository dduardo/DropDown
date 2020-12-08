//
//  ModelProtocol.swift
//  DropDown
//
//  Created by Carlos Eduardo Santiago on 07/12/20.
//  Copyright © 2020 Carlos Eduardo Santiago. All rights reserved.
//

import Foundation

protocol ModelProtocol: Decodable {
    var id: String { get set }
    var name: String  { get set }
}
