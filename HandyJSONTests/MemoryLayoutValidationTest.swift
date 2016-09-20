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

//  Created by zhouzhuo on 8/9/16.
//

import XCTest

class MemoryLayoutValidationTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class A {
        var m1: Int8 = 0
    }

    func testHeadOfClass() {
        let a = A()
        let basePtr = UnsafePointer<Int8>(bitPattern: unsafeAddressOf(a).hashValue).advancedBy(8 + sizeof(Int))
        let realPtr = UnsafeMutablePointer<Int8>(bitPattern: basePtr.hashValue)
        realPtr.memory = 11
        XCTAssert(a.m1 == 11)
    }

    struct B {
        var m1: Int8 = 0
    }

    func testHeadOfStruct() {
        var b = B()
        let basePtr = UnsafePointer<Int8>(bitPattern: withUnsafePointer(&b, { return $0 }).hashValue)
        let realPtr = UnsafeMutablePointer<Int8>(bitPattern: basePtr.hashValue)
        realPtr.memory = 11
        XCTAssert(b.m1 == 11)
    }
}
