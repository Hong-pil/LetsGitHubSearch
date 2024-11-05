//
//  RepoSearchView.swift
//  CodeSquad_GithubSearch
//
//  Created by kimhongpil on 6/13/24.
//

import SwiftUI
import ComposableArchitecture

struct RepoSearchView: View {
    
    /// 뷰가 스토어를 가지고 있는 구조임 (StoreOf를 통해 RepoSearch 리듀서를 Store 타입으로 변환해줌)
    @State var store: StoreOf<RepoSearch>
    
    var body: some View {
        NavigationView {
            Group {
                if(store.isLoading) {
                    ProgressView()
                } else {
                    List {
                        ForEach(store.searchResults, id: \.self) { repo in
                            NavigationLink {
                                Text(repo)
                            } label: {
                                Text(repo)
                            }
                        }
                    }
                }
                Spacer()
            }
            .searchable(text: $store.keyword)
            .navigationTitle("Github Search")
        }
    }
}

#Preview {
    RepoSearchView(
        store: Store(initialState: RepoSearch.State()) {
            RepoSearch()
        }
    )
}
