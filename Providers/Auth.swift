//
//  Auth.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 11/07/2021.
//

import SwiftUI

struct AuthModel: Codable, Identifiable {
    let id = UUID()
    var username: String
    var token: String
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

var userName: String = ""
var token: String = ""

class AuthApi{
    
    
    func authenticate(username: String, password: String ,completion: @escaping (AuthModel) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:8000/api/v1/login/") else { return }
        let info: [String: Any] = [
                "username": username.lowercased(),
                "password": password
                ]
        let jsonInfo = info.percentEncoded()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonInfo
        URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data else{ return }
                let response  = response as? HTTPURLResponse
                    do {
                        let decodedData = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                        if(response?.statusCode == 200){
                            userName = decodedData["username"] as! String
                            token = decodedData["access"] as! String
                            DispatchQueue.main.async {
                                completion(
                                    AuthModel(username: decodedData["username"] as! String, token: decodedData["access"] as! String)
                                )}
                        } else {
                            DispatchQueue.main.async {
                                completion(
                                    AuthModel(username: "", token: "")
                                )}
                        }
                    } catch _ {
                        
                            
                    }
                }.resume()
    }
    
    func isLoggedIn(completion: @escaping (String?) -> ()){
        if(userName.count > 1){
            completion(userName)
        }else{
            completion(nil)
        }
    }
    
//    func getToken(completion: @escaping (String?) -> ()){
//        completion(token)
//    }
    
    func getToken() -> String{
        return token
    }
    
    func getUserName() -> String{
        return userName
    }
    
    func logOut() -> Bool{
        token = ""
        userName = ""
        return true
    }
}

