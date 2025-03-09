//
//  AudioGroup.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

// MARK: define some structs
struct AudioGroup: Identifiable {
    let id = UUID()
    let groupName: String
    let items: [AudioItem]
}

struct AudioItem: Identifiable {
    let id = UUID()
    let filename: String
    let displayName: String
}
