/*
 * Copyright 1999-2101 Alibaba Group.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//  Created by zhouzhuo on 9/20/16.
//

import XCTest
import HandyJSON

class ObjectiveCObjectTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class A: HandyJSON {
        var name: NSString?
        var id: NSString?
        var height: NSNumber?

        required init() {}
    }

    func testSimpleClass() {
        let jsonString = "{\"name\":\"Bob\",\"id\":\"12345\",\"height\":180}"
        guard let a = JSONDeserializer<A>.deserializeFrom(jsonString) else {
            XCTAssert(false)
            return
        }
        XCTAssert(a.name == "Bob")
        XCTAssert(a.id == "12345")
        XCTAssert(a.height == 180)
    }

    class B: HandyJSON {
        var arr1: NSArray?
        var arr2: NSArray?
        var id: Int?

        required init() {}
    }

    func testClassWithArrayProperty() {
        let jsonString = "{\"id\":123456,\"arr1\":[1,2,3,4,5,6],\"arr2\":[\"a\",\"b\",\"c\",\"d\",\"e\"]}"
        guard let b = JSONDeserializer<B>.deserializeFrom(jsonString) else {
            XCTAssert(false)
            return
        }
        XCTAssert(b.id == 123456)
        XCTAssert(b.arr1?.count == 6)
        XCTAssert(b.arr2?.count == 5)
        XCTAssert(b.arr1?.objectAtIndex(5).integerValue == 6)
        XCTAssert((b.arr2?.objectAtIndex(4) as? NSString)?.isEqualToString("e") == true)
    }
}
