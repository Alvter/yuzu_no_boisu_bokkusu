//
//  HomeView.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

// MARK: HomeView
struct HomeView: View {
    @ObservedObject var audioPlayer: AudioPlayer
    @AppStorage("SelectedRole") var selectedRole: Role = .yiji // 获取选定的角色

    // 定义自适应列布局
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 70, maximum: 160), spacing: 10)]
    }

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    ForEach(smallAudioGroups) { group in
                        VStack(alignment: .leading, spacing: 12) {
                            Text(group.groupName)
                                .font(.headline)
                                .padding(.horizontal)
                                .foregroundColor(.blue)

                            LazyVGrid(columns: columns, spacing: 15) {
                                ForEach(group.items) { item in
                                    AudioButton(
                                        audioItem: item, // 传递 AudioItem 对象
                                        audioPlayer: audioPlayer,
                                        selectedRole: selectedRole // 传递选定的角色
                                    )
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                            )
                            .padding(.horizontal, 8)
                        }
                    }
                }
                .padding(.vertical)
                Spacer()
            }
            .navigationTitle("Audio Player")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            // 移除设置按钮
        }
    }
}
