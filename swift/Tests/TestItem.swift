import Foundation
import GildedRose

enum TestItem {
    case expired
    case notExpired
    case zeroQuality
    case agedBrie
    case sulfuras
    case concertTicket(daystoConcert: Int)
    
    var name: String {
        switch self {
        case .expired: return "Expired Item"
        case .notExpired: return "Not Expired Item"
        case .zeroQuality: return "Zero Quality Item"
        case .agedBrie: return "Aged Brie"
        case .sulfuras: return "Sulfuras, Hand of Ragnaros"
        case .concertTicket: return "Backstage passes to a TAFKAL80ETC concert"
        }
    }
    
    var sellIn: Int {
        switch self {
        case .expired: return -1
        case .notExpired: return 5
        case .zeroQuality: return 0
        case .agedBrie: return 5
        case .sulfuras: return 0
        case .concertTicket(let expiry): return expiry
        }
    }
    
    var quality: Int {
        switch self {
        case .expired: return 5
        case .notExpired: return 5
        case .zeroQuality: return 0
        case .agedBrie: return 5
        case .sulfuras: return 80
        case .concertTicket: return 25
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
