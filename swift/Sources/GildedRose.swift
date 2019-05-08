
public class GildedRose {
    var items:[Item]
    
    required public init(items:[Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        let maxQuality = 50
        
        for i in 0..<items.count {
            let item = items[i]
            let isAgedBrie = item.name == "Aged Brie"
            let isConcertTicket = item.name == "Backstage passes to a TAFKAL80ETC concert"
            let isSulfuras = item.name == "Sulfuras, Hand of Ragnaros"
            
            if !isAgedBrie && !isConcertTicket {
                if item.quality > 0 && !isSulfuras {
                    item.quality -= 1
                }
            } else {
                if item.quality < maxQuality {
                    item.quality += 1
                    
                    if isConcertTicket {
                        if item.sellIn < 11 && item.quality < 50 {
                            item.quality += 1
                        }
                        
                        if item.sellIn < 6 && item.quality < maxQuality {
                            item.quality += 1
                        }
                    }
                }
            }
            
            if !isSulfuras {
                item.sellIn -= 1
            }
            
            if item.sellIn < 0 {
                if !isAgedBrie {
                    if !isConcertTicket && (item.quality > 0 && !isSulfuras) {
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
}
