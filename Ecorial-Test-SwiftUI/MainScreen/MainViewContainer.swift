//
//  MainViewContainer.swift
//  Ecorial-Test-SwiftUI
//
//  Created by Ingvar on 02.01.2021.
//

import SwiftUI
import SwiftUI_UDF

struct MainViewContainer: Container {
    typealias ContainerComponent = MainViewComponent


    func map(state: AppState, store: AppEnvironmentStore) -> ContainerComponent.Props {
        .init(
            users: Array(state.allUsers.byId.keys).sorted { $0.value > $1.value },
            userById: { state.allUsers.byId[$0]! }            
        )
    }

    func onContainerAppear(store: EnvironmentStore<AppState>) {
        if store.state.allUsers.byId.keys.isEmpty {
            let fake = UserInfo.fakeItems()
            store.dispatch(AnyAction.DidLoadItems(items: fake, id: UsersFlow.id))
        }
    }
}

