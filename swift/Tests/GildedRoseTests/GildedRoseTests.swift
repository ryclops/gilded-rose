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
        let items = [
            Item(name: "NotExpiredItem", sellIn: 5, quality: 5),
            Item(name: "ExpiredItem", sellIn: -1, quality: 5)
        ]
        
        let unexpiredStartQuality = items[0].quality
        let expiredStartQuality = items[1].quality
        
        let app = GildedRose(items: items);
        app.updateQuality()
        
        XCTAssertEqual(unexpiredStartQuality - 1, app.items[0].quality)
        XCTAssertEqual(expiredStartQuality - 2, app.items[1].quality)
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
