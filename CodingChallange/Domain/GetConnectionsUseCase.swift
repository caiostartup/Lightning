//
//
// GetConnectionsUseCase.swift
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
import Combine

public protocol GetConnectionsUseCaseProtocol {
    
    func getConections() -> AnyPublisher<[Connectivity], Error>
    
}

struct GetConnectionsUseCase {
    
    private var repository: LightningRepository = LightningDataSource()
    private let dateFormatter =  DateFormatter()
    
    public init(){
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    func getConections() async throws -> [ConnectivitySH] {
        try await repository.getConections()
            .value
            .sorted { $0.capacity > $1.capacity }
            .map { ConnectivitySH(
                publicKey: $0.publicKey,
                alias: $0.alias,
                channels: $0.channels,
                capacity: Double($0.capacity) / 100000000.0,
                firstSeen: dateFormatter.string(from: Date(timeIntervalSince1970: Double($0.firstSeen))),
                updatedAt: dateFormatter.string(from: Date(timeIntervalSince1970: Double($0.updatedAt))),
                city: getPtBR($0.city),
                country: getPtBR($0.country)
            )}
    }
    
    private func getPtBR(_ lang: [String: String]?) -> String {
        guard let lang = lang else { return "" }
        return lang.keys.contains("pt-BR") ? lang["pt-BR"]! : lang["en"]!
    }

    
}
