//
//  PostEntity+CoreDataClass.swift
//  PostApi
//
//  Created by kalid on 25/04/2022.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}


public class PostEntity: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case completionDate
    }
    
    
    public required convenience  init(from decoder: Decoder) throws {
        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case id, title, body
        }
        
        
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: CodingKeys.id)
        self.userID = try container.decode(Int64.self, forKey: CodingKeys.userID)
        self.body = try container.decode(String.self, forKey: CodingKeys.body)
        self.title = try container.decode(String.self, forKey: CodingKeys.title)
        
    }
}


