//
//  PostsApi.swift
//  PostApi
//
//  Created by kalid on 23/04/2022.
//

import Foundation
import Combine

class PostsApi{
    private var postsSubscription: AnyCancellable?
    @Published var posts: [PostServerModel] = []
    @Published var isLoading: Bool = false
    
    
    static let shared = PostsApi()
    
    private init(){
        getAllPosts()
    }
    
    
    func getAllPosts(){
       
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")  else {
           return
        }
        isLoading = true
        postsSubscription = NetworkingManager.download(url: url)
            .print("getAllPosts")
            .receive(on: DispatchQueue.main)
            .decode(type: [PostServerModel].self, decoder: JSONDecoder())
        
            .sink { receiveCompletion in
                switch receiveCompletion {
                    
                case .finished:
                    self.isLoading = false
                    self.postsSubscription?.cancel()
                case .failure(let error):
                    self.isLoading = false
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] receiveValue in
                self?.posts = receiveValue
            }
    }
}
