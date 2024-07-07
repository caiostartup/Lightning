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
import CombineMoya
import Combine

public class LightningDataSource: LightningRepository {
    
    static var cancelables = Set<AnyCancellable>()
    
    // Tuck this away somewhere where it'll be visible to anyone who wants to use it
    private let provider: MoyaProvider<LightningService> = MoyaProvider(endpointClosure: { (target: LightningService) -> Endpoint in
        return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
    })
    
    public func getConections() -> AnyPublisher<[Connectivity], Error> {
        Future<[Connectivity], Error> { [self] promise in
            provider.requestPublisher(.connectivity)
                .sink(receiveCompletion: { completion in
                    switch completion{
                    case .finished:
                        print("RECEIVE VALUE COMPLETED")
                    case .failure:
                        print("RECEIVE VALUE FAILED")
                    }
                }, receiveValue: { response in
                    do {
                        let result = try JSONDecoder().decode([Connectivity].self, from: response.data)
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                })
                .store(in: &LightningDataSource.cancelables)
        }.eraseToAnyPublisher()
    }
    
}
