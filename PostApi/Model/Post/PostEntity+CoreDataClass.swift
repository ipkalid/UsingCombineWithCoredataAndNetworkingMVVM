//
//  PostEntity+CoreDataClass.swift
//  PostApi
//
//  Created by kalid on 25/04/2022.
//
//

import Foundation
import CoreData
import RealmSwift
 
 
class LocalPostModel: Object,Codable, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var userID: Int
    @Persisted var title: String?
    @Persisted var body: String?
    
//    convenience init(userID: Int, id: Int, title: String, body: String) {
//        self.init()
////        self.userID = userID
////        self.id = id
////        self.title = title
////        self.body = body
//    }
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }

}

//var x = LocalPostData(





public class PostEntity: NSManagedObject {
    
}


