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
