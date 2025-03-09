//
//  HomeSettingsView.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

// MARK: HomeSetting
struct HomeSettingsView: View
{
    @Environment(\.dismiss) var dismiss // 使用现代关闭方式
    var onDismiss: (() -> Void)? // 用于在关闭设置页面时触发回调
    
    var body: some View
    {
        Form
        {
            
        }
        .navigationTitle("设置")
        .toolbar
        {
            // macOS专属关闭按钮
            #if os(macOS)
            ToolbarItem(placement: .confirmationAction) {
                Button("完成") {
                    onDismiss?() // 触发回调以显示 TabView
                }
            }
            #endif
        }
        #if os(iOS)
        .navigationBarTitle("",displayMode: .inline)
        #endif
        .onDisappear
        {
            onDismiss?() // 在页面消失时触发回调以显示 TabView
        }
    }
}
