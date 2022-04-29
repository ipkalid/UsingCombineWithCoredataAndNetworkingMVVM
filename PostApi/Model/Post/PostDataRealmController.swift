//
//  PostDataRealmController.swift
//  PostApi
//
//  Created by kalid on 29/04/2022.
//

import Combine
import CoreData
import Foundation
import RealmSwift
import Realm

class PostDataRealmController {
    static let shared = PostDataRealmController()
    @Published var savedPosts: [LocalPostModel] = []

//    let container: NSPersistentContainer
    let realmContainer: Realm

    let postsApiService = PostsApi.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
 
        do {
            realmContainer = try Realm()
        } catch(let error) {
            fatalError("Unresolved error \(error)")
        }
//        realmContainer = try! Realm()
//
//        container = NSPersistentContainer(name: "PostApi")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
        fetchData()
        addSubscrpers()
    }

    func fetchData() {
        let fetchedData = realmContainer.objects(LocalPostModel.self)
        savedPosts = Array(fetchedData)
        print(savedPosts.count)
    }

    func addSubscrpers() {
        postsApiService.$posts
            .sink { recivedValues in
                self.saveUniqeData(recivedValues: recivedValues)

            }
            .store(in: &cancellables)
    }

    private func saveUniqeData(recivedValues: [LocalPostModel]) {
        try! realmContainer.write {
            realmContainer.add(recivedValues, update: .all)
        }

//        var _ = recivedValues.map { postServerModel in
//            if !self.savedPosts.contains(where: { postEntity in
//               return postEntity.id == postServerModel.id
//            }){
//                let newPost = PostEntity(context: self.container.viewContext)
//                newPost.id = Int64(postServerModel.id)
//                newPost.userID = Int64(postServerModel.userID)
//                newPost.body = postServerModel.body
//                newPost.title = postServerModel.title
//                self.save()
//            }
//        }
    }

    func save() {
//        do {
//            try container.viewContext.save()
//            fetchData()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
    }
}
