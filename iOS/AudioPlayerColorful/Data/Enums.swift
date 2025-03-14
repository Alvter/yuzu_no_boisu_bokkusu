//
//  Enums.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//


// a enum,but why?
enum Tab
{
    case home
    case order
    case more
    case person
}

// MARK: Role List
enum Role: String, CaseIterable, Identifiable {
    case yiji = "一姬"
    case youzi = "柚"

    var id: String { self.rawValue }

    var filenamePrefix: String {
        switch self {
        case .yiji:
            return "yiji"
        case .youzi:
            return "you"
        }
    }
}


