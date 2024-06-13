//
//  FeatureView.swift
//  CodeSquad_GithubSearch
//
//  Created by kimhongpil on 6/13/24.
//

import SwiftUI
import ComposableArchitecture

struct FeatureView: View {
    let store: StoreOf<Feature>
    
    var body: some View {
        VStack {
            Section {
                Text("\(store.count)")
                Button("Decrement") { store.send(.decrementButtonTapped) }
                Button("Increment") { store.send(.incrementButtonTapped) }
            }
            
            Section {
                Button("Number fact") { store.send(.numberFactButtonTapped) }
            }
            
            if let fact = store.numberFact {
                Text(fact)
            }
        }
    }
}

#Preview {
    FeatureView(
        store: Store(initialState: Feature.State()) {
            Feature()
        }
    )
}
