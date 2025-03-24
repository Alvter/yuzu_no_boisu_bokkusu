//
//  Enums.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import Foundation

// a enum,but why?
enum Tab
{
    case home
    case order
    case more
    case person
}


// MARK: Role List
struct Role: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var filenamePrefix: String
}


