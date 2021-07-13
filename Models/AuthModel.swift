//
//  AuthModel.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 11/07/2021.
//

import Foundation
import SwiftUI

struct User: Codable, Identifiable {
    var id = UUID()
    var token: String
    var username: String
}

class Api {
    func authenticate() {
        guard let url = URL(string: "http://127.0.0.1:8000/api/v1/login/") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
        }
    }
}
