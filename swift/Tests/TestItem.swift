import Foundation
import GildedRose

enum TestItem {
    case expired
    case notExpired
    case zeroQuality
    
    var name: String {
        switch self {
        case .expired: return "ExpiredItem"
        case .notExpired: return "NotExpiredItem"
        case .zeroQuality: return "ZeroQualityItem"
        }
    }
    
    var sellIn: Int {
        switch self {
        case .expired: return -1
        case .notExpired: return 5
        case .zeroQuality: return 0
        }
    }
    
    var quality: Int {
        switch self {
        case .expired: return 5
        case .notExpired: return 5
        case .zeroQuality: return 0
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
