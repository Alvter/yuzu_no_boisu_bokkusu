//
//  RoleManager.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/24.
//

import SwiftUI
import Foundation

class RoleManager: ObservableObject {
    @Published var roles: [Role] = []

    init() {
        loadRoles()
    }

    func loadRoles() {
        if let url = Bundle.main.url(forResource: "roles", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = PropertyListDecoder()
                roles = try decoder.decode([Role].self, from: data)
            } catch {
                print("Error decoding plist: \(error)")
                // 可以设置一个默认的角色列表，以防止加载失败
                roles = [
                    Role(id: "default", name: "默认角色", filenamePrefix: "default")
                ]
            }
        } else {
            print("Could not find roles.plist")
            // 可以设置一个默认的角色列表，以防止文件找不到
            roles = [
                Role(id: "default", name: "默认角色", filenamePrefix: "default")
            ]
        }
    }
}

