//
//  ContentView.swift
//  AudioPalyer
//
//  Created by 四月初一茶染绮良 on 2025/3/5.
//

import SwiftUI

// MARK: ContentView
struct ContentView: View
{
    @StateObject var audioPlayer = AudioPlayer()
    
    // create a grid layout with adaptive size
    private var columns: [GridItem]
    {
        [GridItem(.adaptive(minimum: 70, maximum: 160), spacing: 10)]
    }
    
    @State private var selectedTab: Tab = .home
    
    @State private var isTabViewVisible = true // 控制 TabView 的显示状态
    
    var body: some View
    {
        TabView(selection: $selectedTab)
        {
            // main page view
            HomeView(audioPlayer: audioPlayer)
                .tabItem
            {
                Label("主页", systemImage: selectedTab == .home ? "house.fill" : "house")
            }
            .tag(Tab.home)
            
            // order view
            OrderView(audioPlayer: audioPlayer)
                .tabItem
            {
                Label("报菜名", systemImage: selectedTab == .order ? "square.3.stack.3d" : "square.3.stack.3d.slash")
            }
            .tag(Tab.order)
            
            // more view
            SettingsView()
                .tabItem
            {
                Label("设置", systemImage: selectedTab == .more ? "gearshape.fill" : "gearshape")
            }
            .tag(Tab.more)
            
            // person view
            PersonView()
                .tabItem
            {
                Label("个人",systemImage: selectedTab ==  .person ? "person.crop.circle.fill" : "person.crop.circle")
            }
            .tag(Tab.person)
        }
    }
}


// MARK: - 修改密码子页面
struct ChangePasswordView: View {
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        Form {
            Section("当前密码") {
                SecureField("输入旧密码", text: $oldPassword)
            }
            
            Section("新密码") {
                SecureField("输入新密码", text: $newPassword)
                SecureField("确认新密码", text: $confirmPassword)
            }
        }
        .navigationTitle("修改密码")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}

#Preview
{
    ContentView()
}
