//
//  Created by Kumpels and Friends on 09.11.22.
//  Copyright © 2022 Kumpels and Friends. All rights reserved.
//

import APIClient
import Foundation

extension URL {
    static let cleemaBaseURL: Self = URL(string: "https://cleema.app")!
    static let cleemaAPIBaseURL: Self = URL(string: "https://api.cleema.app")!
}

extension APIClient {
    static var shared: APIClient = .init(baseURL: .cleemaAPIBaseURL, token: CleemaKeys().apiToken)
}
