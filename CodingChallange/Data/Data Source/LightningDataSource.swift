//
//
// MempoolDataSource.swift
// CodingChallange
//
// Created by Caio Mansho on 07/07/24
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
        

import Foundation
import Moya

public struct LightningDataSource: LightningRepository {
    
    public func getConection() -> Connectivity? {
        // Tuck this away somewhere where it'll be visible to anyone who wants to use it
        let provider: MoyaProvider<LightningService> = MoyaProvider(endpointClosure: { (target: LightningService) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
        })
        
        provider.request(.connectivity) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let response = try moyaResponse.filterSuccessfulStatusCodes()
                    let data = try response.mapJSON()
                }
                catch {
                    // show an error to your user
                }
                // do something in your app
            case let .failure(error): break
                // TODO: handle the error == best. comment. ever.
            }
        }
        return nil
        
    }
}
