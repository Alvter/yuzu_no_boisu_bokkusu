//
//  Settings.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

// MARK: Settings View
struct SettingsView: View {
    @AppStorage("SelectedRole") var selectedRole: Role = .yiji // 获取选定的角色

    var body: some View {
        NavigationStack {
            Form {
                Section("角色设置") {
                    Picker("角色", selection: $selectedRole) {
                        ForEach(Role.allCases) { role in
                            Text(role.rawValue).tag(role)
                        }
                    }
                    .pickerStyle(.menu) // iOS 默认下拉样式
                }
                // 可以添加更多的设置选项，例如音量控制、播放速度控制等
            }
            .navigationTitle("设置")
        }
    }
}
