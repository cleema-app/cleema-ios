//
//  Created by Kumpels and Friends on 21.11.22.
//  Copyright © 2022 Kumpels and Friends. All rights reserved.
//

import APIClient
import Foundation
import QuizClient

public extension QuizClient {
    static func live(from apiClient: APIClient) -> Self {
        .init(loadState: {
            try await apiClient.quizState()
        }, saveState: { state in
            try await apiClient.save(state: state)
        })
    }
}
