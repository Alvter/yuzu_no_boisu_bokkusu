//
//  AudioButton.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

// MARK: AudioButton
// AudioButton 组件是一个用于显示播放/暂停按钮的视图。
struct AudioButton: View {
    // 接收一个 AudioItem 对象，该对象包含音频的相关信息
    let audioItem: AudioItem
    @ObservedObject var audioPlayer: AudioPlayer
    // 默认选择的角色，控制音频文件名前缀
    var selectedRole: Role = .yiji

    var body: some View {
        Button(action: {
            // 创建完整的文件名，包括角色前缀和音频文件名
            let fullFilename = "\(selectedRole.filenamePrefix)_\(audioItem.filename)"
            // 切换音频播放状态
            audioPlayer.togglePlayback(for: fullFilename)
        }) {
            // 垂直排列按钮的内容
            VStack(spacing: 8) {
                ZStack {
                    // 设置按钮背景，播放时为蓝色，暂停时为蓝色透明度较低
                    RoundedRectangle(cornerRadius: 16)
                        .fill(audioPlayer.isPlaying(filename: "\(selectedRole.filenamePrefix)_\(audioItem.filename)") ? Color.blue : Color.blue.opacity(0.7))
                        .shadow(color: .black.opacity(0.1), radius: 4, y: 2)

                    Image(systemName: audioPlayer.isPlaying(filename: "\(selectedRole.filenamePrefix)_\(audioItem.filename)") ? "pause.fill" : "play.fill")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .aspectRatio(1, contentMode: .fit) // 保持按钮为正方形

                // 显示音频的名称
                Text(audioItem.displayName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)  // 自适应文本大小，确保文本在空间不足时缩小
            }
            .padding(10)  // 按钮内容的内边距
            .background(Color(.systemBackground))
            .cornerRadius(12)  // 圆角半径
            .shadow(radius: 3)
        }
        .buttonStyle(.plain)  // 使用普通按钮样式，不添加系统默认样式
    }
}
