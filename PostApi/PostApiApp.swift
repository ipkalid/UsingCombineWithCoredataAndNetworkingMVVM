//
//  PostApiApp.swift
//  PostApi
//
//  Created by kalid on 23/04/2022.
//

import SwiftUI

@main
struct PostApiApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
            }
            .navigationViewStyle(.stack)

          
        }
    }
}
