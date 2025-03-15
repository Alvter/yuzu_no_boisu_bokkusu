//
//  AudioButton.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

// MARK: AudioButton
struct AudioButton: View {
    let audioItem: AudioItem // 接收 AudioItem 对象
    @ObservedObject var audioPlayer: AudioPlayer
    var selectedRole: Role = .yiji  // 增加选定的角色属性

    var body: some View {
        Button(action: {
            let fullFilename = "\(selectedRole.filenamePrefix)_\(audioItem.filename)"
            audioPlayer.togglePlayback(for: fullFilename)
        }) {
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(audioPlayer.isPlaying(filename: "\(selectedRole.filenamePrefix)_\(audioItem.filename)") ? Color.blue : Color.blue.opacity(0.7))
                        .shadow(color: .black.opacity(0.1), radius: 4, y: 2)

                    Image(systemName: audioPlayer.isPlaying(filename: "\(selectedRole.filenamePrefix)_\(audioItem.filename)") ? "pause.fill" : "play.fill")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .aspectRatio(1, contentMode: .fit) // keep square shape

                Text(audioItem.displayName) // 使用 audioItem.displayName
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5) // auto-fit text size
            }
            .padding(10)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 3)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue, lineWidth: audioPlayer.isPlaying(filename: "\(selectedRole.filenamePrefix)_\(audioItem.filename)") ? 2 : 0)
            )
        }
        .buttonStyle(.plain)
    }
}
