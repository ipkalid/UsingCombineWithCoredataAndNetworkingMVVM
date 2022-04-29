//
//  PostModel.swift
//  PostApi
//
//  Created by kalid on 23/04/2022.
//

import Foundation



class PostServerModel: Codable, Identifiable {
    let userID, id: Int
    let title, body: String
    
    
    
    func toPostEntity() -> PostEntity{
        let newPostEntity = PostEntity()
        newPostEntity.id = Int64(self.id)
        newPostEntity.userID = Int64(self.id)
        newPostEntity.title = self.title
        newPostEntity.body = self.body

        return newPostEntity
    }
    

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
