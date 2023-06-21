//
//  Created by Kumpels and Friends on 03.01.23.
//  Copyright © 2023 Kumpels and Friends. All rights reserved.
//

import ComposableArchitecture
import Foundation
import ProfileEditFeature
import RegisterUserFeature

public struct ProfileData: ReducerProtocol {
    public enum State: Equatable {
        case show(ProfileUser.State = .init())
        case edit(ProfileEdit.State)
        case convertAccount(ConvertAccount.State)
    }

    public enum Action: Equatable {
        case user(ProfileUser.Action)
        case editProfile(ProfileEdit.Action)
        case convertAccount(ConvertAccount.Action)
        case cancelButtonTapped
        case submitConvertAccountTapped
    }

    public var body: some ReducerProtocolOf<ProfileData> {
        Reduce { state, action in
            .none
        }
        .ifCaseLet(/State.show, action: /Action.user, then: ProfileUser.init)
        .ifCaseLet(/State.edit, action: /Action.editProfile, then: ProfileEdit.init)
        .ifCaseLet(/State.convertAccount, action: /Action.convertAccount, then: ConvertAccount.init)
    }
}

public extension ProfileData.State {
    var isEditingProfile: Bool {
        switch self {
        case .show: return false
        default: return true
        }
    }

    var user: User? {
        switch self {
        case let .show(state):
            return state.user
        case let .edit(state):
            return state.originalUser
        case .convertAccount:
            return nil
        }
    }
}

import SwiftUI
struct ProfileDataView: View {
    let store: StoreOf<ProfileData>

    var body: some View {
        WithViewStore(store) { viewStore in
            SwitchStore(store) {
                CaseLet(state: /ProfileData.State.edit, action: ProfileData.Action.editProfile) {
                    ProfileEditView(store: $0)
                        .transition(.scale)
                        .animation(.default, value: viewStore.isEditingProfile)
                }

                CaseLet(state: /ProfileData.State.convertAccount, action: ProfileData.Action.convertAccount) {
                    ConvertAccountView(store: $0)
                        .transition(.scale)
                        .animation(.default, value: viewStore.isEditingProfile)
                }

                CaseLet(state: /ProfileData.State.show, action: ProfileData.Action.user) {
                    ProfileUserView(store: $0)
                        .transition(.opacity)
                        .animation(.default, value: viewStore.isEditingProfile)
                }
            }
        }
    }
}
