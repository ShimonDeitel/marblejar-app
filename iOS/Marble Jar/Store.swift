import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [MarbleItem] = []
    @Published var isPro: Bool = false

    /// Free-tier cap. Always kept comfortably above seed data count so a
    /// fresh install never trips the paywall immediately.
    static let freeLimit = 15

    private let fileURL: URL

    init() {
        let support = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: support, withIntermediateDirectories: true)
        fileURL = support.appendingPathComponent("marblejar_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: MarbleItem) {
        guard canAddMore else { return }
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: MarbleItem) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: MarbleItem) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([MarbleItem].self, from: data) {
            items = decoded
        } else {
            items = seedData()
            save()
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    private func seedData() -> [MarbleItem] {
        [
        MarbleItem(name: "Cat's Eye Blue", maker: "Vacor", pattern: "Cat's Eye", size: "0.6 in"),
        MarbleItem(name: "Swirl Classic", maker: "Marble King", pattern: "Swirl", size: "0.7 in"),
        MarbleItem(name: "Aggie Green", maker: "Akro Agate", pattern: "Aggie", size: "0.5 in")
        ]
    }
}
