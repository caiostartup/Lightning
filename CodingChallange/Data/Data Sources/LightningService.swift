//
//
// MemPoolService.swift
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

enum LightningService {
    case connectivity
    
}

extension LightningService: TargetType {
    var baseURL: URL { URL(string: "https://mempool.space/api/v1")! }
    
    var path: String {
        switch self {
        case .connectivity: "/lightning/nodes/rankings/connectivity"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .connectivity: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .connectivity: .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .connectivity:
            // Provided you have a file named accounts.json in your bundle.
            guard let url = Bundle.main.url(forResource: "connectivity", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}


// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}

