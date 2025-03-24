//
//  AudioCheckBox.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

// MARK: AudioCheckbox
struct AudioCheckbox: View {
    let audioItem: AudioItem
    @ObservedObject var audioPlayer: AudioPlayer
    @Binding var selectedFiles: Set<String>
    let categoryColor: Color
    @Environment(\.colorScheme) var colorScheme // 获取当前的配色方案
    @EnvironmentObject var OrderViewModel: OrderViewModel // 获取 OrderViewModel 的实例
    
    var isSelected: Bool {
        selectedFiles.contains(audioItem.filename)
    }

    var body: some View {
        Button(action: {
            // 点击按钮时切换选中状态
            if isSelected {
                selectedFiles.remove(audioItem.filename)
            } else {
                selectedFiles.insert(audioItem.filename)
            }
            
            // 彩蛋逻辑：检查是否点击了“南”按钮
            if audioItem.filename == "southwind" {
                OrderViewModel.handleSouthWindTap() // 使用 viewModel 调用
            }
        }) {
            VStack {
                Text(audioItem.displayName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isSelected ? .white : (colorScheme == .dark ? .white : .black)) // 根据选中状态和配色方案设置文字颜色
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding(10)
            .frame(width: 80, height: 60)
            .background(isSelected ? categoryColor : (colorScheme == .dark ? Color.black : Color.white)) // 根据选中状态和配色方案设置背景色
            .cornerRadius(12)
            .shadow(radius: 3)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? categoryColor : Color.gray.opacity(0.3), lineWidth: 1) // 根据选中状态设置边框颜色
            )
        }
        .buttonStyle(.plain)
    }
}
