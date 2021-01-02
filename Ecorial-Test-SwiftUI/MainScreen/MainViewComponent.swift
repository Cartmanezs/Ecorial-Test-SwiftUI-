//
//  MainViewComponent.swift
//  Ecorial-Test-SwiftUI
//
//  Created by Ingvar on 02.01.2021.
//

import SwiftUI
import SwiftUI_UDF

struct MainViewComponent<AddUser: Container>: Component {
    struct Props {
        var users: [UserInfo.Id]
        var userById: (UserInfo.Id) -> UserInfo
        var addUser: AddUser
    }
    
    @State private var isUserSettings: Bool = true
    @State private var isAddUserPresented = false

    var props: Props

    var body: some View {
        VStack {
            headerView
            ScrollView {
                if self.isUserSettings {
                    usersList
                } else {
                    Text("2")
                }
            }
            Spacer()
        }
        .padding(.top, 15)
    }
}

extension MainViewComponent {
    var headerView: some View {
        VStack {
            HStack(spacing: 22) {
                Spacer()
                Text("My Memorials")
                Spacer()
                Button(action: $isAddUserPresented.toggleAction()) {
                    Image.addIcon
                }
                .sheetContainer(isPresented: $isAddUserPresented, container: props.addUser)
                .padding(.trailing, 20)
            }
            .padding(.leading, 60)
            
            segmentedControl
                .frame(width: 242, height: 43)
                .background(
                    RoundedCorner(radius: 14, corners: [.allCorners])
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 0.9)
                )
        }
    }
    
    var segmentedControl: some View {
        
        GeometryReader  { proxy in
            ZStack(alignment: isUserSettings ? .leading : .trailing) {
                Color.white
                Color.segmentedGray
                    .frame(width: proxy.size.width / 2, height: proxy.size.height - 5)
                    .cornerRadius(14)
                    .padding(.leading, 2)
                    .padding(.trailing, 2)
                
                HStack{
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.isUserSettings = true
                        }
                    }) {
                        Text("Created")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(isUserSettings ? .white : .segmentedGray)
                    }
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.isUserSettings = false
                        }
                    }) {
                        Text("Favorite")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(isUserSettings ? .segmentedGray : .white)
                    }
                }
            }
        }
        .cornerRadius(13)
    }
    
    var usersList: some View {
        VStack(spacing: 5) {
            ForEach(users, id: \.self) { user in
                UserRowView(user: user)
//                    .onTapGesture {
//                        self.projectAction(project)
//                    }
            }
        }
    }
}

// MARK: - Computed Properties
extension MainViewComponent {
    var users: [UserInfo] {
        self.props.users.compactMap { self.props.userById($0) }
    }
}

struct MainViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        MainViewComponent(props:
            .init(
                users: [],
                userById:  {_ in UserInfo.fakeItem()},
                addUser: RenderContainer(viewToRender: AddUserComponent_Previews.previews)
            )
        )
    }
}
