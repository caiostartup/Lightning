//
//
// ConnectivityDetail.swift
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
import SwiftUI


struct ConnectivityDetailRow: View {
    var title: String
    var desc: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(desc)
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
}

struct ConnectivityDetail: View {
    
    var connectivity: ConnectivityVH
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                Text(connectivity.alias)
                    .font(.title)
                
                Divider()
                ConnectivityDetailRow(title: "Key", desc: connectivity.publicKey)
                Divider()
                ConnectivityDetailRow(title: "Channels", desc: String(connectivity.channels))
                Divider()
                ConnectivityDetailRow(title: "Capacity", desc: String(connectivity.capacity))
                Divider()
                ConnectivityDetailRow(title: "First seen", desc: String(connectivity.firstSeen))
                Divider()
                ConnectivityDetailRow(title: "Updated at", desc: String(connectivity.updatedAt))
                Divider()
                ConnectivityDetailRow(title: "City", desc: connectivity.city)
                Divider()
                ConnectivityDetailRow(title: "Country", desc: connectivity.country)
                Divider()
            }
            .padding()
            
            Spacer()
        }
    }
}


#Preview {
    ConnectivityDetail(connectivity: ConnectivityVH.mockConnectivity())
}
