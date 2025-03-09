//
//  PersonalView.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

// MARK: PersonalView
struct PersonView: View {
    let stats = ["帖子": 238, "关注": 369, "粉丝": 5482]
    //@EnvironmentObject var userProfile: UserProfile
    @StateObject private var userProfile = UserProfile()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // 头像部分
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(.blue)
                        .background(.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.blue, lineWidth: 2))
                        .shadow(radius: 5)
                    
                    // 用户名
                    Text("\(userProfile.username)")
                        .font(.title.bold())
                        .foregroundStyle(.primary)
                    
                    // 统计信息
                    HStack(spacing: 30) {
                        ForEach(stats.sorted(by: <), id: \.key) { key, value in
                            VStack {
                                Text("\(value)")
                                    .font(.title2).bold()
                                Text(key)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .padding(.vertical)
                    
                    // 个人简介
                    Text("\(userProfile.bio)")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 修改编辑资料按钮
                                   NavigationLink {
                                       EditProfileView()
                                   } label: {
                                       Text("编辑资料")
                                           .frame(width: 200)
                                           .padding(.vertical, 8)
                                   }
                                   .buttonStyle(.bordered)
                                   .tint(.blue)
                    
                    // 功能列表
                    Section {
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Label("设置", systemImage: "gear")
                        }
                        
                        NavigationLink {
                            PrivacyView()
                        } label: {
                            Label("隐私设置", systemImage: "lock")
                        }
                        
                        NavigationLink {
                            HelpView()
                        } label: {
                            Label("帮助与反馈", systemImage: "questionmark.circle")
                        }
                    }
                    .labelStyle(DefaultLabelStyle())
                    .padding(.vertical, 8)
                    .foregroundStyle(.primary)
                }
                .padding()
            }
            .navigationTitle("个人中心")
            .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(userProfile)
    }
}
