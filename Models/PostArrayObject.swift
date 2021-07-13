//
//  PostArrayObject.swift
//  TemiShare
//
//  Created by TemiTope Kayode on 10/07/2021.
//

import Foundation

class PostArrayObject: ObservableObject {
    
    @Published var dataArray = [PostModel]()
    
    init(){
        let post1 = PostModel(postID: "", userID: "", username: "Jesse", caption: "My Dog", dateCreated: Date(), likeCount: 5, likedByUser: false)
        
        let post2 = PostModel(postID: "", userID: "", username: "Tife", caption: nil, dateCreated: Date(), likeCount: 3, likedByUser: true)
        
        let post3 = PostModel(postID: "", userID: "", username: "Engryankey", caption: "Pythonista", dateCreated: Date(), likeCount: 10, likedByUser: false)
        
        let post4 = PostModel(postID: "", userID: "", username: "Bammy", caption: "I want to buy this dog", dateCreated: Date(), likeCount: 8, likedByUser: true)
        
        self.dataArray.append(post1)
        self.dataArray.append(post2)
        self.dataArray.append(post3)
        self.dataArray.append(post4)
    }
    
}
