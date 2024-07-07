//
//
// CodingChallangeTests.swift
// CodingChallangeTests
//
// Created by Caio Mansho on 06/07/24
// Copyright © 2024 Caio Mansho. All rights reserved.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
        

import XCTest
import Moya
@testable import CodingChallange

final class CodingChallangeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataSource() throws {
        let stubbingProvider = MoyaProvider<LightningService>(stubClosure: MoyaProvider.immediatelyStub)
    
        stubbingProvider.request(.connectivity) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let response = try moyaResponse.filterSuccessfulStatusCodes()
                    let data = try response.mapJSON()
                    print(data)
                }
                catch {
                    // show an error to your user
                }
                // do something in your app
            case let .failure(error): break
                // TODO: handle the error == best. comment. ever.
            }
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
