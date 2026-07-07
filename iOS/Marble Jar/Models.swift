import Foundation

struct MarbleItem: Identifiable, Codable, Equatable {
    var id: UUID
    var dateAdded: Date
    var name: String
    var maker: String
    var pattern: String
    var size: String

    init(id: UUID = UUID(), dateAdded: Date = Date(), name: String, maker: String, pattern: String, size: String) {
        self.id = id
        self.dateAdded = dateAdded
        self.name = name
        self.maker = maker
        self.pattern = pattern
        self.size = size
    }

    static func blank() -> MarbleItem {
        MarbleItem(name: "", maker: "", pattern: "", size: "")
    }
}
