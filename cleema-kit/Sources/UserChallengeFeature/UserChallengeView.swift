//
//  Created by Kumpels and Friends on 24.01.23.
//  Copyright © 2023 Kumpels and Friends. All rights reserved.
//

import Components
import ComposableArchitecture
import Models
import NukeUI
import Styling
import SwiftUI
import UserProgressesFeature

public struct UserChallengeView: View {
    let store: StoreOf<UserChallenge>

    @Environment(\.styleGuide) var styleGuide

    public init(store: StoreOf<UserChallenge>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                GroupBox {
                    VStack(alignment: .leading, spacing: 8) {
                        if let image = viewStore.userChallenge.challenge.image?.image {
                            LazyImage(url: image.url, resizingMode: .aspectFill)
                                .frame(height: 225)
                        }

                        Text(L10n.challenge)

                        Text(viewStore.userChallenge.challenge.title)
                            .font(.montserrat(style: .title, size: 24))

                        HStack(spacing: 30) {
                            VStack(alignment: .leading) {
                                Text(L10n.start)

                                Text(
                                    viewStore.userChallenge.challenge.startDate
                                        .formatted(date: .numeric, time: .omitted)
                                )
                                .font(.montserratBold(style: .headline, size: 14))
                            }

                            VStack(alignment: .leading) {
                                Text(L10n.end)

                                Text(
                                    viewStore.userChallenge.challenge.endDate
                                        .formatted(date: .numeric, time: .omitted)
                                )
                                .font(.montserratBold(style: .headline, size: 14))
                            }
                        }

                        ChallengeProgressView(userChallenge: viewStore.userChallenge)
                            .font(.montserrat(style: .footnote, size: 12))

                        AnswerView(store: store.scope(state: \.answerState))

                        Divider()
                            .padding(.top, 24)

                        VStack(spacing: 0) {
                            Text(viewStore.userChallenge.challenge.description)

                            IfLetStore(
                                store
                                    .scope(
                                        state: \.progressesState,
                                        action: UserChallenge.Action.userProgresses
                                    )
                            ) { userProgressesStore in
                                UserProgressesView(store: userProgressesStore)
                            }
                        }
                    }
                    .font(.montserrat(style: .footnote, size: 12))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                }
                .padding(.horizontal, styleGuide.screenEdgePadding)
                .frame(maxWidth: .infinity)

                Button {
                    viewStore.send(.leaveTapped)
                } label: {
                    Text(L10n.Action.Leave.label)
                        .font(.montserrat(style: .caption, size: 12))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.white)
                .padding(.horizontal, styleGuide.screenEdgePadding * 2)
            }
            .background(ScreenBackgroundView())
            .onAppear {
                viewStore.send(.fetch)
            }
            .alert(store.scope(state: \.alertState), dismiss: UserChallenge.Action.dismissAlert)
        }
    }
}

#if DEBUG
struct UserChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        let today = Date.now.add(days: 4)
        NavigationView {
            UserChallengeView(
                store: .init(
                    initialState: .init(
                        userChallenge: .fake(
                            challenge: .fake(
                                title: "Everesting",
                                description: "8000 HM every day",
                                interval: .daily,
                                startDate: .now,
                                endDate: .now.add(days: 4)
                            ),
                            answers: [0: .succeeded, 1: .succeeded]
                        ),
                        progressesState: .init(userProgresses: [
                            .init(totalAnswers: 12, succeededAnswers: 7, user: .fake()),
                            .init(totalAnswers: 3, succeededAnswers: 2, user: .fake()),
                            .init(totalAnswers: 6, succeededAnswers: 6, user: .fake()),
                            .init(totalAnswers: 9, succeededAnswers: 5, user: .fake())
                        ], maxAllowedAnswers: 4)
                    ),
                    reducer: UserChallenge()
                        .dependency(\.date, .constant(today))
                        .dependency(\.challengesClient, .noop)
                )
            )
        }
        .cleemaStyle()
    }
}
#endif
