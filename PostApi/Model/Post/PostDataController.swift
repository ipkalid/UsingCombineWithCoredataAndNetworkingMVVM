//
//  Persistence.swift
//  PostApi
//
//  Created by kalid on 23/04/2022.
//

import CoreData
import Combine

class PostDataController{
    static let shared = PostDataController()
    @Published var savedPosts : [PostEntity] = []
    
    let container: NSPersistentContainer
    
    
    let postsApiService = PostsApi.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        container = NSPersistentContainer(name: "PostApi")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        fetchData()
        addSubscrpers()
    }
    
    func fetchData(){
        let request =  PostEntity.fetchRequest()
        do {
            savedPosts = try container.viewContext.fetch(request)
           
        } catch let error {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
    func addSubscrpers(){
        postsApiService.$posts
            .sink { recivedValues in
                self.saveUniqeData(recivedValues: recivedValues)

            }
            .store(in: &cancellables)
        
      
    }
    
    private func saveUniqeData(recivedValues :[PostServerModel]){
        var _ = recivedValues.map { postServerModel in
            if !self.savedPosts.contains(where: { postEntity in
               return postEntity.id == postServerModel.id
            }){
                let newPost = PostEntity(context: self.container.viewContext)
                newPost.id = Int64(postServerModel.id)
                newPost.userID = Int64(postServerModel.userID)
                newPost.body = postServerModel.body
                newPost.title = postServerModel.title
                self.save()
            }
        }
        
    }
     
    func save(){
        do {
            try container.viewContext.save()
            fetchData()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
