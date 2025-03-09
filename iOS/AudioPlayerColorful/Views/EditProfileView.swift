//
//  Untitled.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

// MARK: - 编辑资料页面
struct EditProfileView: View {
    @EnvironmentObject var userProfile: UserProfile
    @Environment(\.dismiss) private var dismiss
    
    // 使用局部状态来编辑数据
    @State private var editingUsername: String = ""
    @State private var editingBio: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("基本信息") {
                    TextField("用户名", text: $editingUsername)
                        .autocorrectionDisabled(true)
                    
                    TextField("个人简介", text: $editingBio, axis: .vertical)
                        .lineLimit(3...5)
                }
                
                Section("账号安全") {
                    Text("现在你无需对账号的安全做修改")
                        .padding()
                }
            }
            .navigationTitle("编辑资料")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("完成") {
                        userProfile.username = editingUsername
                        userProfile.bio = editingBio
                        userProfile.save()  // 新增保存方法
                        dismiss()
                    }
                    .bold()
                }
            }
            .onAppear {
                // 初始化编辑字段
                editingUsername = userProfile.username
                editingBio = userProfile.bio
            }
        }
    }
}
