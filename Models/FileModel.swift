//
//  FileModel.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 11/07/2021.
//


import SwiftUI
import Foundation

struct FileModel: Codable, Identifiable {
    let id = UUID()
    var identifier: String
    var downloaded: Int
    var mime_type: String
    var size_mb: String
    var thumbnail: String
    var title: String
    var uploaded_date: String
    var authorised_user: String?
    var description: String
    var owner: Dictionary<String, String>
    var location: String
    var restricted_by_user: Bool
    var restricted_by_country: Bool
    
}

struct FileDetailModel: Codable, Identifiable {
    let id = UUID()
    var identifier: String
    var downloaded: Int
    var mime_type: String
    var size_mb: String
    var thumbnail: String
    var title: String
    var uploaded_date: String
    var authorised_user: String?
    var description: String
    var owner: Dictionary<String, String>
    var location: String
    var restricted_by_user: Bool
    var restricted_by_country: Bool
    
    
}



class FileApi {
    let token = AuthApi().getToken()
    
    func getFiles(completion: @escaping ([FileModel]) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:8000/api/v1/files/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data else{ return }
                    do{
                        let decodedData =  try JSONDecoder().decode([FileModel].self, from: data)
                        DispatchQueue.main.async {
                            completion(decodedData)
                        }
                    }catch _{
                        
                            
                    }
                }.resume()
    }
    
    func getFileDetail(identifier: String ,completion: @escaping (FileModel) -> ()){
        guard let url = URL(string: "http://127.0.0.1:8000/api/v1/files/validatefile/\(identifier)/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data else{ return }
                    let response  = response as? HTTPURLResponse
                    do {
                        let decodedData = try JSONSerialization.jsonObject(with: data) as! [[String:Any]]
                        
                        if(response?.statusCode == 200){
                            DispatchQueue.main.async {
                                completion(
                                    FileModel(identifier: decodedData[0]["identifier"] as! String, downloaded: decodedData[0]["downloaded"] as! Int, mime_type: decodedData[0]["mime_type"] as! String, size_mb: decodedData[0]["size_mb"] as! String, thumbnail: decodedData[0]["thumbnail"] as! String, title: decodedData[0]["title"] as! String, uploaded_date: decodedData[0]["uploaded_date"] as! String, authorised_user:  decodedData[0]["authorised_user"] as? String, description: decodedData[0]["description"] as! String, owner: decodedData[0]["owner"] as! Dictionary<String, String>, location: decodedData[0]["location"] as! String, restricted_by_user: decodedData[0]["restricted_by_user"] as! Bool, restricted_by_country: decodedData[0]["restricted_by_country"] as! Bool)
                                )
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(
                                    FileModel(identifier: "", downloaded: 0, mime_type: "", size_mb: "", thumbnail: "", title: "", uploaded_date: "", authorised_user:  "", description: "", owner: ["": ""], location: "", restricted_by_user: false, restricted_by_country: false)
                                )
                            }

                        }
                    } catch _ {
                        
                            
                    }
                }.resume()
    }
}
