import Foundation
import XCTest

@testable import GildedRose

class GildedRoseTests: XCTestCase {
    var shop: GildedRose!
    var expectedEndQuality: Int?
    var expectedEndSellIn: Int?
    
    var firstItem: Item {
        return shop.items[0]
    }
    
    override func setUp() {
        super.setUp()
        shop = GildedRose(items: [])
    }
    
    func oneDayPasses() {
        shop.updateQuality()
    }
    
    func itemIsExpectedQuality() {
        guard let expectedQuality = expectedEndQuality else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(expectedQuality == firstItem.quality)
    }
    
    func itemIsExpectedSellIn() {
        guard let expectedSellIn = expectedEndSellIn else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(expectedSellIn == firstItem.sellIn)
    }
    
    // MARK: - Tests
    
    func testFoo() {
        // Given
        let foo = Item(name: "foo", sellIn: 0, quality: 0)
        shop.items = [foo]
        
        // When
        oneDayPasses()
        
        // Then name is unchanged
        XCTAssertEqual("foo", firstItem.name);
    }
    
    func testQualityDegradesByOneBeforeSellByDate() {
        // Given
        let notExpiredItem = itemOfType(.notExpired)
        expectedEndQuality = notExpiredItem.quality - 1
        shop.items = [notExpiredItem]
        
        // When
        oneDayPasses()
        
        // Then unexpired item reduces in quality by 1
        itemIsExpectedQuality()
    }
    
    func testQualityDegradesByTwoAfterSellByDate() {
        // Given
        let expiredItem = itemOfType(.expired)
        expectedEndQuality = expiredItem.quality - 2
        shop.items = [expiredItem]
        
        // When
        oneDayPasses()
        
        // Then unexpired item reduces in quality by 2
        itemIsExpectedQuality()
    }
    
    func testQualityOfItemIsNeverNegative() {
        // Given
        let zeroQualityItem = itemOfType(.zeroQuality)
        expectedEndQuality = 0
        shop.items = [zeroQualityItem]
        
        XCTAssertEqual(0, zeroQualityItem.quality)
        
        // When
        oneDayPasses()
        
        // Then quality remains as zero
        itemIsExpectedQuality()
    }
    
    func testAgedBrieIncreasesInQualityWithAge() {
        // Given
        let agedBrie = itemOfType(.agedBrie)
        expectedEndQuality = agedBrie.quality + 1
        shop.items = [agedBrie]
        
        // When
        oneDayPasses()
        
        // Then Aged Brie has increased in quality by 1
        itemIsExpectedQuality()
    }
    
    func testQualityOfItemNeverMoreThanFifty() {
        // Given
        let agedBrie = itemOfType(.agedBrie)
        agedBrie.quality = 50
        expectedEndQuality = 50
        shop.items = [agedBrie]
        
        // When
        oneDayPasses()
        
        // Then Aged Brie still has a quality of 50
        itemIsExpectedQuality()
    }
    
    func testSulfurasNeverDecreasesInQuality() {
        // Given
        let sulfuras = itemOfType(.sulfuras)
        expectedEndQuality = sulfuras.quality
        shop.items = [sulfuras]
        
        // When
        oneDayPasses()
        
        // Then Sulfuras' quality is unchanged (it's legendary)
        itemIsExpectedQuality()
    }
    
    func testSulfurasNeverHasToBeSold() {
        // Given
        let sulfuras = itemOfType(.sulfuras)
        expectedEndSellIn = sulfuras.sellIn
        shop.items = [sulfuras]
        
        // When
        oneDayPasses()
        
        // Then Sulfuras' sell by date remains unchanged
        itemIsExpectedSellIn()
    }
    
    func testConcertTicketIncreasesInQualityByOneIfMoreThanTenDays() {
        // Given
        let ticket = concertTicket(daysToConcert: 15)
        expectedEndQuality = ticket.quality + 1
        shop.items = [ticket]
        
        // When
        oneDayPasses()
        
        // Then ticket quality has increased by 1
        itemIsExpectedQuality()
    }
    
    func testConcertTicketIncreasesInQualityByTwoIfTenDaysOrLess() {
        // Given
        let ticket = concertTicket(daysToConcert: 10)
        expectedEndQuality = ticket.quality + 2
        shop.items = [ticket]
        
        // When
        oneDayPasses()
        
        // Then ticket quality has increased by 2
        itemIsExpectedQuality()
    }
    
    func testConcertTicketIncreasesInQualityByThreeIfFiveDaysOrLess() {
        // Given
        let ticket = concertTicket(daysToConcert: 5)
        expectedEndQuality = ticket.quality + 3
        shop.items = [ticket]
        
        // When
        oneDayPasses()
        
        // Then ticket quality has increased by 3
        itemIsExpectedQuality()
    }
    
    func testConcertTicketQualityIsZeroAfterConcert() {
        // Given
        let ticket = concertTicket(daysToConcert: 0)
        expectedEndQuality = 0
        shop.items = [ticket]

        // When
        oneDayPasses()
        
        // Then ticket quality is zero, you've missed the concert
        itemIsExpectedQuality()
    }
    
    func testConcertTicketCannotExceedMaxQuality() {
        // Given
        let ticket = concertTicket(daysToConcert: 2)
        ticket.quality = 50
        expectedEndQuality = shop.maxQuality
        shop.items = [ticket]
        
        // When
        oneDayPasses()
        
        // Then ticket quality is zero, you've missed the concert
        itemIsExpectedQuality()
    }
    
    func testConjuredItemsDegradeTwiceAsFast() {
        // Given
        let conjuredItem = itemOfType(.conjured)
        expectedEndQuality = conjuredItem.quality - 2
        shop.items = [conjuredItem]
        
        // When
        oneDayPasses()
        
        // Then conjured item has degraded by two
        itemIsExpectedQuality()
    }
    
    func testConjuredItemsCannotBeNegativeQuality() {
        // Given
        let conjuredItem = itemOfType(.conjured)
        conjuredItem.quality = 1
        expectedEndQuality = 0
        shop.items = [conjuredItem]
        
        // When
        oneDayPasses()
        
        // Then conjured item has degraded by two
        itemIsExpectedQuality()
    }
}

#if os(Linux)
extension GildedRoseTests {
    static var allTests : [(String, (GildedRoseTests) -> () throws -> Void)] {
        return [
            ("testFoo", testFoo),
            ("testQualityDegradesByOneBeforeSellByDate", testQualityDegradesByOneBeforeSellByDate),
            ("testQualityDegradesByTwoAfterSellByDate", testQualityDegradesByTwoAfterSellByDate),
            ("testQualityOfItemIsNeverNegative", testQualityOfItemIsNeverNegative),
            ("testAgedBrieIncreasesInQualityWithAge", testAgedBrieIncreasesInQualityWithAge),
            ("testQualityOfItemNeverMoreThanFifty", testQualityOfItemNeverMoreThanFifty),
            ("testSulfurasNeverDecreasesInQuality", testSulfurasNeverDecreasesInQuality),
            ("testSulfurasNeverHasToBeSold", testSulfurasNeverHasToBeSold),
            ("testConcertTicketIncreasesInQualityByOneIfMoreThanTenDays", testConcertTicketIncreasesInQualityByOneIfMoreThanTenDays),
            ("testConcertTicketIncreasesInQualityByTwoIfTenDaysOrLess", testConcertTicketIncreasesInQualityByTwoIfTenDaysOrLess),
            ("testConcertTicketIncreasesInQualityByThreeIfFiveDaysOrLess", testConcertTicketIncreasesInQualityByThreeIfFiveDaysOrLess),
            ("testConcertTicketQualityIsZeroAfterConcert", testConcertTicketQualityIsZeroAfterConcert),
            ("testConcertTicketCannotExceedMaxQuality", testConcertTicketCannotExceedMaxQuality),
            ("testConjuredItemsDegradeTwiceAsFast", testConjuredItemsDegradeTwiceAsFast),
            ("testConjuredItemsCannotBeNegativeQuality", testConjuredItemsCannotBeNegativeQuality)
        ]
    }    
}
#endif
