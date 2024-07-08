//
//
// ContentView.swift
// CodingChallange
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


import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ConnectivityVM()
    
    var body: some View {
        VStack {
            if vm.loading {
                ProgressView()
            } else {
                NavigationSplitView {
                    List(vm.connectivities) { connectivity in
                        NavigationLink {
                            ConnectivityDetail(connectivity: connectivity)
                        } label: {
                            ConnectivityRow(connectivity: connectivity)
                        }
                    }
                    .navigationTitle("Lightning")
                } detail: {
                    Text("Selecione")
                }
            }
        }
        .onAppear{
            Task {
                await vm.requestPremierLeagueData()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
