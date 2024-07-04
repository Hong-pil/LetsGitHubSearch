//
//  RepoSearch.swift
//  CodeSquad_GithubSearch
//
//  Created by kimhongpil on 6/13/24.
//

import ComposableArchitecture

@Reducer
struct RepoSearch {
    
    @ObservableState
    struct State: Equatable {
        // TODO: 지금 앱은 어떤 상태들로 정의되는가?
        var keyword = ""
        var searchResults = [String]()
        var isLoading = false
    }
    
    enum Action: BindableAction {
        // TODO: 상태들을 변화시키는 사용자의 액션은 무엇인가?
        case binding(BindingAction<State>)
        //case keywordChanged(String)
        case search
        case dataLoaded(TaskResult<RepositoryModel>)
    }
    
    /// 네트워크 통신
    @Dependency(\.repoSearchClient) var repoSearchClient
    
    /// Debounce 기능
    /// : 설정한 타이머 시간 동안 이벤트 방출이 없으면, 마지막에 들어온 이벤트를 방출하는 기능
    /// : 무수히 많고 잦은 이벤트 방출을 막을 수 있기 때문에 자동완성 또는 연관검색어 기능에서 자주 활용됨
    @Dependency(\.continuousClock) var clock
    private enum SearchDebounceId { case request }
    
    /// Reducer 에서만 State 를 변경할 수 있음
    /// 액션들이 항상 상태만 깔끔하게 변화시키지는 않고, api를 호출하거나 데이터를 저장하고 읽는 SideEffect 들이 있을 수 있기 때문에
    /// 그 부분을 Reducer 의 리턴타입인 Effect<Action>으로 추상화를 한다.
    /// SideEffect가 발생하지 않으면 return .none 을 하고, SideEffect가 발생한다면 run 으로 Effect 를 return 한다.
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            // TODO: 각각의 Action이 발생했을 때 상태는 어떻게 변화해야 하는가?
            switch action {
            case .binding(\.keyword):
                
                // 예외 처리
                if state.keyword == "" {
                    state.isLoading = false
                    state.searchResults = []
                    return .cancel(id: SearchDebounceId.request)
                }
                
                return .run { send in
                    try await self.clock.sleep(for: .seconds(0.5))
                    await send(.search)
                }
                .cancellable(id: SearchDebounceId.request, cancelInFlight: true)
                
            case .search:
                state.isLoading = true
                
                /// 비동기 작업 (Effect.run)
                /// TaskResult 는 TCA에서 정의한 타입이고, Swift의 Result 타입과 동일하게 enum 타입이며, success, failure 중 하나의 값을 가진다.
                ///
                /// [keyword = state.keyword] 구문은 클로저 내부에서 state.keyword를 keyword로 사용하겠다는 의미이다.
                return Effect.run { [keyword = state.keyword] send in
                    let result = await TaskResult { try await repoSearchClient.search(keyword) }
                    await send(.dataLoaded(result))
                }
                
            case let .dataLoaded(.success(repositoryModel)):
                state.isLoading = false
                state.searchResults = repositoryModel.items.map { $0.name }
                return .none
                
            case .dataLoaded(.failure):
                state.isLoading = false
                state.searchResults = []
                return .none
                
            case .binding:
                return .none
            }
        }
    }
    
}
