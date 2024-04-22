//
//  ProfileUpdateQuery.swift
//  Uyubudan
//
//  Created by SangRae Kim on 4/22/24.
//

import Foundation

struct ProfileUpdateQuery: Encodable {
    let nick: String
    let profile: Data
}
