//
//  Created by Kumpels and Friends on 05.01.23.
//  Copyright © 2023 Kumpels and Friends. All rights reserved.
//

import Foundation

public struct JoinedChallenge: Equatable {
    public enum Answer: Int, Equatable, CaseIterable, Codable {
        case failed
        case succeeded
    }

    public var challenge: Challenge
    public var answers: [Int: Answer]

    public init(
        challenge: Challenge = .init(isJoined: true),
        answers: [Int: Answer] = [:]
    ) {
        self.challenge = challenge
        self.answers = answers
    }
}

public extension JoinedChallenge {
    var numberOfUnitsDone: Int {
        answers.values.filter { $0 == .succeeded }.count
    }

    var unit: String {
        challenge.duration.unit
    }

    var duration: Int {
        challenge.duration.unitValueCount
    }

    var progress: Double {
        guard challenge.duration.unitValueCount > 0 else { return 0 }
        let value = Double(numberOfUnitsDone) / Double(challenge.duration.unitValueCount)
        return min(1, max(0, value))
    }

    var isComplete: Bool {
        answers.count == challenge.duration.unitValueCount
    }

    func index(for date: Date) -> Int {
        let todayIndexFromEnd = challenge.endDate.numberOfDays(to: date) + 1
        return challenge.duration.unitValueCount + todayIndexFromEnd
    }
}

extension JoinedChallenge: Identifiable {
    public var id: Challenge.ID { challenge.id }
}
