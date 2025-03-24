//
//  EggView.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/24.
//

import SwiftUI

struct EggView: View {
    @ObservedObject var audioPlayer: AudioPlayer
    let easterEggFilename = "Southern_Cross" // 替换为你的彩蛋音频文件名
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("恭喜你发现了彩蛋！")
                .font(.largeTitle)
                .padding()

            Button("返回") {
                audioPlayer.stopPlayback(for: easterEggFilename) // 停止播放
                dismiss() // 关闭当前视图
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black) // 全屏背景色
        .foregroundColor(.white)
        .onAppear {
            audioPlayer.startPlayback(for: easterEggFilename)
        }
        .onDisappear {
            audioPlayer.stopPlayback(for: easterEggFilename) // 确保视图消失时停止播放
        }
    }
}
