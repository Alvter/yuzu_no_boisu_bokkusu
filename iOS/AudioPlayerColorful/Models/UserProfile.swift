//
//  UserProfile.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

// MARK: UserProfile class
class UserProfile: ObservableObject
{
    @Published var username: String = ""
    @Published var bio: String = ""
    func save()
    {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(bio, forKey: "bio")
    }
}
