//
//
// ConnectivityVH.swift
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

protocol ConnectivityVH {
    
//    * publicKey: A chave pública que identifica o node na rede.
    var publicKey: String { get }
    
//    * alias: Um nome definido pelo próprio node.
    var alias:  String { get }
    
//    * channels: A quantidade de canais que o node possui.
    var channels: Int { get }
    
//    * capacity: A quantidade de Bitcoin (em sats) que o node possui nos canais.
    var capacity: Int { get }
    
//    * firstSeen: A data e hora de quando esse node se tornou público.
    var firstSeen: Int { get }
    
//    * updatedAt: A data e hora de quando as informações do node foram atualizadas pela última vez.
    var updatedAt: Int { get }
        
//    * city: A cidade onde esse node está localizado (pode não existir).
//    * No idioma do nome da cidade e país, utiliza o pt-BR se disponível, caso contrário, use en. Não é necessário suportar internacionalização.
    var city: [String: String]? { get }
        
//    * country: O país onde esse node está localizado.
    var country: [String: String]? { get }
    
}
