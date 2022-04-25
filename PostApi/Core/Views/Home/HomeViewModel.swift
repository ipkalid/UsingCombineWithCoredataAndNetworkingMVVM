//
//  HomeViewModel.swift
//  PostApi
//
//  Created by kalid on 23/04/2022.
//

import Foundation
import Combine
class HomeViewModel:ObservableObject{
    @Published var posts :[PostEntity] = [PostEntity]()
    @Published var isLoading = false
    
    
    
    private let postApi = PostsApi.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscripers()
    }
    
    
    private func addSubscripers(){
        
        PostDataController.shared.$savedPosts
            .sink(receiveValue: { [weak self] receiveValue in
                self?.posts = receiveValue
            })
            .store(in: &cancellables)
        
        postApi.$isLoading
            .sink(receiveValue: { [weak self] receiveValue in
                self?.isLoading = receiveValue
            })
            .store(in: &cancellables)
    }
    
    
    func refrechData(){
        postApi.getAllPosts()
    }
    
}
