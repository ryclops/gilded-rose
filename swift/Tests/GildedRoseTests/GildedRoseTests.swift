import Foundation
import XCTest

@testable import GildedRose

class GildedRoseTests: XCTestCase {

    func testFoo() {
        let items = [Item(name: "foo", sellIn: 0, quality: 0)]
        let app = GildedRose(items: items);
        app.updateQuality();
        XCTAssertEqual("foo", app.items[0].name);
    }
    
    func testQualityDegradesTwiceAsFastAfterSellByDate() {
        let testItems = items(ofTypes: [.notExpired, .expired])
        let unexpiredStartQuality = testItems[0].quality
        let expiredStartQuality = testItems[1].quality
        
        let app = GildedRose(items: testItems);
        app.updateQuality()
        
        XCTAssertEqual(unexpiredStartQuality - 1, app.items[0].quality)
        XCTAssertEqual(expiredStartQuality - 2, app.items[1].quality)
    }
    
    func testQualityOfItemIsNeverNegative() {
        let testItems = items(ofTypes: [.zeroQuality])
        let itemStartQuality = testItems[0].quality
        XCTAssertEqual(0, itemStartQuality)
        
        let app = GildedRose(items: testItems)
        app.updateQuality()
        
        XCTAssertEqual(0, itemStartQuality)
    }
    
    func testAgedBrieIncreasesInQualityWithAge() {
        let testItems = items(ofTypes: [.agedBrie])
        let itemStartQuality = testItems[0].quality
        
        let app = GildedRose(items: testItems)
        app.updateQuality()
        
        XCTAssertEqual(itemStartQuality + 1, app.items[0].quality)
    }
    
    func testQualityOfItemNeverMoreThanFifty() {
        let testItems = items(ofTypes: [.agedBrie])
        testItems[0].quality = 50
        
        let itemStartQuality = testItems[0].quality
        
        let app = GildedRose(items: testItems)
        app.updateQuality()
        
        XCTAssertEqual(itemStartQuality, app.items[0].quality)
    }
    
    func testSulfurasNeverDecreasesInQuality() {
        let testItems = items(ofTypes: [.sulfuras])
        let itemStartQuality = testItems[0].quality
        
        let app = GildedRose(items: testItems)
        app.updateQuality()
        
        XCTAssertEqual(itemStartQuality, app.items[0].quality)
    }
    
    func testSulfurasNeverHasToBeSold() {
        let testItems = items(ofTypes: [.sulfuras])
        let itemStartSellIn = testItems[0].sellIn
        
        let app = GildedRose(items: testItems)
        app.updateQuality()
        
        XCTAssertEqual(itemStartSellIn, app.items[0].sellIn)
    }
    
    func testConcertTicketIncreasesInQualityByOneIfMoreThanTenDays() {
        let testItems = items(ofTypes: [.concertTicket(daysToConcert: 15)])
        let itemStartQuality = testItems[0].quality
        
        let app = GildedRose(items: testItems)
        app.updateQuality()
        
        XCTAssertEqual(itemStartQuality + 1, app.items[0].quality)
    }
    
    func testConcertTicketIncresesInQualityByTwoIfTenDaysOrLess() {
        let testItems = items(ofTypes: [.concertTicket(daysToConcert: 10)])
        let itemStartQuality = testItems[0].quality
        
        let app = GildedRose(items: testItems)
        app.updateQuality()
        
        XCTAssertEqual(itemStartQuality + 2, app.items[0].quality)
    }
    
    func testConcertTicketIncresesInQualityByThreeIfFiveDaysOrLess() {
        let testItems = items(ofTypes: [.concertTicket(daysToConcert: 5)])
        let itemStartQuality = testItems[0].quality
        
        let app = GildedRose(items: testItems)
        app.updateQuality()
        
        XCTAssertEqual(itemStartQuality + 3, app.items[0].quality)
    }
}

#if os(Linux)
extension GildedRoseTests {
    static var allTests : [(String, (GildedRoseTests) -> () throws -> Void)] {
        return [
            ("testFoo", testFoo),
        ]
    }    
}
#endif
