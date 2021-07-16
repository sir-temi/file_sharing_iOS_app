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

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

class FileApi {
    let token = AuthApi().getToken()
    
    func getFiles(completion: @escaping ([[String:Any]]) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:8000/api/v1/files/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{ return }
            do {
                let decodedData = try JSONSerialization.jsonObject(with: data) as! [[String:Any]]
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
    
    
    func uploadFile(imageToUpload: UIImage, byUser: Bool, byCountry: Bool, title: String, description: String, authUser: String, sizeMb: String, sizeBytes: Double) {
        
        let hashers = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let imagename = String((0..<6).map{ _ in hashers.randomElement()! })
        let fileName = "\(imagename).jpg"
        
        guard let countryUrl = URL(string: "http://ip-api.com/json") else { return }
        var request1 = URLRequest(url: countryUrl)
        request1.httpMethod = "GET"
        
    
        let myUrl = NSURL(string: "http://127.0.0.1:8000/api/v1/files/");
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let param = [
            "title"  : title,
            "description"    : description,
            "authorised_user": authUser,
            "bytes" : String(format: "%.0f", sizeBytes),
            "mb" : sizeMb,
            "location" : "",
            "restricted_by_user" : byUser,
            "restricted_by_country": byCountry,
            "file_name": fileName,
            
        ] as [String : Any]
        
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")


        let imageData = imageToUpload.jpegData(compressionQuality: 1)
        if imageData == nil  {
            return
        }

        request.httpBody = encodeBody(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary, fileName: fileName) as Data

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in

                if error != nil {
                    print("error=\(error!)")
                    return
                }

                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("response data = \(responseString!)")

            }

            task.resume()
        }




    func encodeBody(parameters: [String: Any]?, filePathKey: String?, imageDataKey: NSData, boundary: String, fileName: String) -> NSData {
            let body = NSMutableData();

            if parameters != nil {
                for (key, value) in parameters! {
                    body.appendString(string: "--\(boundary)\r\n")
                    body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString(string: "\(value)\r\n")
                }
            }

            let filename = fileName
            let mimetype = "image/jpg"

            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
            body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
            body.append(imageDataKey as Data)
            body.appendString(string: "\r\n")
            body.appendString(string: "--\(boundary)--\r\n")

            return body
        }

        func generateBoundaryString() -> String {
            return "Boundary-\(NSUUID().uuidString)"
        }

    }

   

