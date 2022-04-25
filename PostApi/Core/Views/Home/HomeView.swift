//
//  HomeView.swift
//  PostApi
//
//  Created by kalid on 23/04/2022.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    var body: some View {
        
        VStack{
            if vm.isLoading{
                ProgressView()
            }
            else{
                
                List {
                    ForEach(vm.posts){
                        Text($0.title)
                    }
                }
                .refreshable {
                    vm.refrechData()
                }
            }
        }
        .navigationTitle("\(vm.posts.count)")
        .navigationBarTitleDisplayMode(.inline)
      
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
