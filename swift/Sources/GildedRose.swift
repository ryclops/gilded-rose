
public class GildedRose {
    let maxQuality = 50
    var items:[Item]
    
    required public init(items:[Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        
        for i in 0..<items.count {
            let item = items[i]
            updateQualityForItem(item)
            updateSellInForItem(item)
        }
    }
    
    private func updateQualityForItem(_ item: Item) {
        let isNormalRulesItem = (!item.isAgedBrie && !item.isConcertTicket) && (item.quality > 0 && !item.isSulfuras)
        
        if isNormalRulesItem {
            item.quality -= 1
        } else if item.quality < maxQuality {
            item.quality += 1
            
            if item.isConcertTicket {
                if item.sellIn < 11 && item.quality < maxQuality {
                    item.quality += 1
                }
                
                if item.sellIn < 6 && item.quality < maxQuality {
                    item.quality += 1
                }
            }
        }
    }
    
    private func updateSellInForItem(_ item: Item) {
        if !item.isSulfuras {
            item.sellIn -= 1
        }
        
        if item.sellIn < 0 {
            if !item.isAgedBrie {
                if !item.isConcertTicket && (item.quality > 0 && !item.isSulfuras) {
                    item.quality -= 1
                } else {
                    item.quality -= item.quality
                }
            } else if item.quality < maxQuality {
                item.quality += 1
            }
        }
    }
}

extension Item {
    var isAgedBrie: Bool {
        return name == "Aged Brie"
    }
    
    var isConcertTicket: Bool {
        return name == "Backstage passes to a TAFKAL80ETC concert"
    }
    
    var isSulfuras: Bool {
        return name == "Sulfuras, Hand of Ragnaros"
    }
}
