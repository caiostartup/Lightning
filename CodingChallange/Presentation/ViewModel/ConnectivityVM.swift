//
//
// ConnectivityVM.swift
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
import SwiftUI

class ConnectivityVM: ObservableObject {
    
    var cancelable = Set<AnyCancellable>()
    
    @Published var connectivities : [ConnectivitySH] = []
    @Published var loading = false
//    @State var sort = false
    @Published var error: String? = nil
    
    private var getConnectionsUC = GetConnectionsUseCase()
    
    public func requestPremierLeagueData(_ sort: Bool = false) async {
        loading = true
        do {
            let fetchedData = try await getConnectionsUC.getConections(sort)
            await MainActor.run {
                loading = false
                connectivities = fetchedData
            }
        } catch {
            if let errorModel = error as? ErrorModel {
                self.error = errorModel.msg
            } else {
                self.error = error.localizedDescription
            }
        }
    }
}
