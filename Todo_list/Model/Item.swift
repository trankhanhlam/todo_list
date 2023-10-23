//
//  Item.swift
//  Todo_list
//
//  Created by Tran Lam on 12/10/2023.
//

import Foundation
import SwiftData

@Model
final class ItemEntity {
    var timestamp: Date
    var id: Int?
    var title: String?
    var detail: String?

    init(timestamp: Date) {
        self.timestamp = timestamp
    }

    func covertToItem() -> Item {
        return Item(timestamp: self.timestamp, id: UUID(),
                    title: self.title!,
                    detail: self.detail!)
    }
}

struct Item: Codable {

    var timestamp: Date?
    var id: UUID
    var title: String
    var detail: String

//    init(from decoder: Decoder) throws { }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.detail, forKey: .detail)
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case title = "titleTask"
        case detail = "detailTask"
    }

    init(timestamp: Date? = nil, id: UUID, title: String, detail: String) {
        self.timestamp = timestamp
        self.id = id
        self.title = title
        self.detail = detail
    }

}

extension Item {
    // https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        detail = try values.decode(String.self, forKey: .detail)
    }
}
