//
//  User.swift
//  Todo_list
//
//  Created by Tran Lam on 16/10/2023.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String

    private enum CodingKeys: CodingKey {
        case id
        case name
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
    }
}
