import Foundation
import GildedRose

enum TestItem {
    case expired
    case notExpired
    case zeroQuality
    case agedBrie
    
    var name: String {
        switch self {
        case .expired: return "Expired Item"
        case .notExpired: return "Not Expired Item"
        case .zeroQuality: return "Zero Quality Item"
        case .agedBrie: return "Aged Brie"
        }
    }
    
    var sellIn: Int {
        switch self {
        case .expired: return -1
        case .notExpired: return 5
        case .zeroQuality: return 0
        case .agedBrie: return 5
        }
    }
    
    var quality: Int {
        switch self {
        case .expired: return 5
        case .notExpired: return 5
        case .zeroQuality: return 0
        case .agedBrie: return 5
        }
    }
}

func items(ofTypes types: [TestItem]) -> [Item] {
    var models: [Item] = []
    
    for type in types {
        models.append(itemOfType(type))
    }
    
    return models
}

func itemOfType(_ type: TestItem) -> Item {
    return Item(name: type.name, sellIn: type.sellIn, quality: type.quality)
}
