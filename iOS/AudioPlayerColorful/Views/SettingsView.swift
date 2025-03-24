//
//  Settings.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

// MARK: Settings View
struct SettingsView: View {
    @ObservedObject var roleManager = RoleManager()
    @AppStorage("SelectedRoleId") var selectedRoleId: String = "yiji" // 使用角色ID存储

    var selectedRole: Role? {
        roleManager.roles.first { $0.id == selectedRoleId }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("角色设置") {
                    Picker("角色", selection: $selectedRoleId) {
                        ForEach(roleManager.roles) { role in
                            Text(role.name).tag(role.id)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("设置")
            .onAppear {
                // 确保在视图出现时加载角色列表
                roleManager.loadRoles()
            }
        }
    }
}
