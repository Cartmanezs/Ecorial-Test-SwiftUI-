//
//  AddUserContainer .swift
//  Ecorial-Test-SwiftUI
//
//  Created by Ingvar on 02.01.2021.
//

import SwiftUI
import SwiftUI_UDF

struct AddUserContainer: Container {
    typealias ContainerComponent = AddUserComponent
    
    @Environment(\.presentationMode) var presentationMode
    
    func map(state: AppState, store: AppEnvironmentStore) -> ContainerComponent.Props {
        .init(
            title: Binding(
                get: {""},// { state.addExpenseForm.title },
                set: { store.dispatch(AnyAction.UpdateUserTitle(text: $0)) }
            )
        )
    }
    func onContainerAppear(store: EnvironmentStore<AppState>) {

    }
}
