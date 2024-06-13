//
//  CodeSquad_GithubSearchApp.swift
//  CodeSquad_GithubSearch
//
//  Created by kimhongpil on 6/13/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct CodeSquad_GithubSearchApp: App {
    var body: some Scene {
        WindowGroup {
            //ContentView()
            
//            FeatureView(
//                store: Store(initialState: Feature.State()) {
//                    Feature()
//                }
//            )
            
            RepoSearchView(
                store: Store(initialState: RepoSearch.State()) {
                    RepoSearch()
                }
            )
            
        }
    }
}
