//
//  AudioCheckBox.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI
import os.log

// MARK: AudioCheckBox
struct AudioCheckbox: View
{
    let audioItem: AudioItem
    @ObservedObject var audioPlayer: AudioPlayer
    @Binding var selectedFiles: Set<String>
    let categoryColor: Color
    
    var body: some View
    {
        Button(action:
        {
            // 点击按钮时切换选中状态
            if selectedFiles.contains(audioItem.filename)
            {
                selectedFiles.remove(audioItem.filename)
                let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let plistURL: URL
                plistURL = documentsDir.appendingPathComponent("roles.plist")
                let log = OSLog(subsystem: "com.yourapp", category: "paths")
                os_log("Plist Path: %{public}@", log: log, plistURL.path)
            }
            else
            {
                selectedFiles.insert(audioItem.filename)
            }
        })
        {
            VStack
            {
                Text(audioItem.displayName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(selectedFiles.contains(audioItem.filename) ? .white : .black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding(10)
            .frame(width: 80, height: 60)
            .background(selectedFiles.contains(audioItem.filename) ? categoryColor : Color.white)
            .cornerRadius(12)
            .shadow(radius: 3)
        }
        .buttonStyle(.plain)
    }
}
