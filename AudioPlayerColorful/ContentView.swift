//
//  ContentView.swift
//  AudioPalyer
//
//  Created by 四月初一茶染绮良 on 2025/3/5.
//

import SwiftUI
import AVFoundation

class AudioPlayer: NSObject, ObservableObject
{
    // MARK: some global variables
    private var player :AVAudioPlayer?
    @Published var isPlaying = false
    private var players: [String: (player: AVAudioPlayer, shouldReset: Bool)] = [:]
    private var shouldResetPlayback = false // Reset Sysbolm
    private var playQueue: [String] = [] 
    private var isQueuePlaying = false 
    @Published var currentPlaying: String?  // put the current playing file name here()
    {
        didSet
        {
            if isPlaying
            {
                guard player?.isPlaying == true
                else
                {
                    isPlaying = false
                    return
                }
            }
            else
            {
                guard player?.isPlaying == false
                else
                {
                    isPlaying = true
                    return
                }
            }
        }
    }
    
    // MARK: play control
    func togglePlayback(for filename: String)
    {
        DispatchQueue.main.async
        {
            // stop other playback
            if let current = self.currentPlaying, current != filename
            {
                self.stopPlayback(for: current)
            }
            if self.isPlaying(filename: filename)
            {
                self.pausePlayback(for: filename)
            }
            else
            {
                self.startPlayback(for: filename)
            }
        }
    }
    
    // MARK: start playback queue
    func startPlaybackQueue(for filenames: [String]) 
    {
        playQueue = filenames
        isQueuePlaying = true
        playNext()
    }

    // MARK: Next play
    private func playNext() 
    {
        guard !playQueue.isEmpty 
        else 
        {               
            isQueuePlaying = false
            return
        }
        let filename = playQueue.removeFirst()
        startPlayback(for: filename)
    }
    
    // MARK: load audio file if needed
    private func loadAudioIfNeeded(_ filename: String) 
    {
        guard players[filename] == nil else { return }

            guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3")
            else
            {
                print("Audio file not found: \(filename)")
                return
            }

            do 
            {
                let player = try AVAudioPlayer(contentsOf: url)
                player.delegate = self
                players[filename] = (player: player, shouldReset: true) // initialize player and set shouldReset to true
            } 
            catch 
            {
                print("Audio player initialization failed: \(error)")
            }
    }
    
    // MARK: handle playback interruption
    private func handlePlaybackInterruption() 
    {
        player?.pause()
        isPlaying = false
        shouldResetPlayback = true // set reset symbol
    }
    
    // MARK: start playback
    func startPlayback(for filename: String)
    {
        loadAudioIfNeeded(filename)
        
        guard let playerInfo = players[filename] else { return }
        let player = playerInfo.player // get player
        
        do
        {
            #if os(iOS)
            try AVAudioSession.sharedInstance().setActive(true)
            #endif
            
            if playerInfo.shouldReset || player.currentTime >= player.duration {
                player.currentTime = 0
                players[filename]?.shouldReset = false
        }
            
            player.play() // call play method
            currentPlaying = filename
        }
        catch
        {
            print("Playback failed: \(error)")
            currentPlaying = nil
        }
    }
    
    override init() {
            super.init()
            setupAudioSession()
            setupInterruptionObserver()
        }
    
    // MARK: set interruption observer in iOS
    private func setupInterruptionObserver() 
    {
        #if os(iOS)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleInterruption),
            name: AVAudioSession.interruptionNotification,
            object: nil
        )
        #endif
    }

    
    // MARK: handle interruption in iOS
    #if os(iOS)
    @objc private func handleInterruption(notification: Notification) 
    {
        guard let userInfo = notification.userInfo,
        let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
        let type = AVAudioSession.InterruptionType(rawValue: typeValue) else { return }

        switch type 
        {
        case .began:
        if let current = currentPlaying
        {      
            pausePlayback(for: current)
            // the symbol needs to be reset
            players[current]?.shouldReset = true
        }
        case .ended:
           break 
        @unknown default:
           break
        }
    }
    #endif

    // MARK: setup audio session
    func setupAudioSession() 
    {
        #if os(iOS)
        do 
        {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } 
        catch 
        {
            print("Audio session setup failed: \(error)")
        }
        #endif
    }
    
    // MARK: pause playback
    private func pausePlayback(for filename: String)
    {
        players[filename]?.player.pause()
        currentPlaying = nil
        players[filename]?.shouldReset = true
    }

    // MARK: stop playback
    private func stopPlayback(for filename: String)
    {
        players[filename]?.player.stop()
        players[filename]?.player.currentTime = 0
        currentPlaying = nil
        players[filename]?.shouldReset = true // update reset symbol
    }

    // MARK: check if is playing
    func isPlaying(filename: String) -> Bool
    {
        return currentPlaying == filename && players[filename]?.player.isPlaying == true
    }
}

// MARK: AVAudioplayerDelegate
extension AudioPlayer: AVAudioPlayerDelegate
{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) 
    {
        DispatchQueue.main.async 
        {
            if let filename = self.players.first(where: { $0.value.player == player })?.key 
            {
                self.stopPlayback(for: filename)
                self.players[filename]?.shouldReset = true // update reset symbol
                
                if self.isQueuePlaying 
                {
                    self.playNext()
                }
            }
        }
    }
}

// MARK: define some structs
struct AudioGroup: Identifiable {
    let id = UUID()
    let groupName: String
    let items: [AudioItem]
}

struct AudioItem: Identifiable {
    let id = UUID()
    let filename: String
    let displayName: String
}

// MARK: data
// todo: consider to use localizable string
private let allAudioGroups = [
    AudioGroup(
        groupName: "立直",
        items: [
            AudioItem(filename: "lizhi", displayName: "立直"),
            AudioItem(filename: "wlizhi", displayName: "双立直"),
            AudioItem(filename: "yifa", displayName: "一发")
        ]
    ),
    AudioGroup(
        groupName: "役牌",
        items: [
            AudioItem(filename: "eastwind", displayName: "东风"),
            AudioItem(filename: "southwind", displayName: "南风"),
            AudioItem(filename: "westwind", displayName: "西风"),
            AudioItem(filename: "northwind", displayName: "北风"),
            AudioItem(filename: "lianeastwind", displayName: "连东"),
            AudioItem(filename: "liansouthwind", displayName: "连南"),
            AudioItem(filename: "lianwestwind", displayName: "连西"),
            AudioItem(filename: "liannorthwind", displayName: "连北"),
            AudioItem(filename: "white", displayName: "白"),
            AudioItem(filename: "facai", displayName: "发"),
            AudioItem(filename: "redmid", displayName: "中"),
            AudioItem(filename: "smallsan", displayName: "小三元")
        ]
    ),
    AudioGroup(
        groupName: "幺九",
        items: [
            AudioItem(filename: "duanyaojiu", displayName: "断幺九"),
            AudioItem(filename: "chunquan", displayName: "纯全"),
            AudioItem(filename: "hunquan", displayName: "混全"),
            AudioItem(filename: "hunlaotou", displayName: "混老头")
        ]
    ),
    AudioGroup(
        groupName: "顺子",
        items:[
            AudioItem(filename: "pinghe", displayName: "平和"),
            AudioItem(filename: "yibeikou", displayName: "一杯口"),
            AudioItem(filename: "erbeikou", displayName: "二杯口"),
            AudioItem(filename: "yiqi", displayName: "一气通贯"),
            AudioItem(filename: "sansetongshun", displayName: "三色同顺")
        ]
    ),
    AudioGroup(
        groupName: "刻子",
        items:[
            AudioItem(filename: "sangangzi", displayName: "三杠子"),
            AudioItem(filename: "sansetongke", displayName: "三色同刻"),
            AudioItem(filename: "duiduihe", displayName: "对对和"),
            AudioItem(filename: "sananke", displayName: "三暗刻")
        ]
    ),
    AudioGroup(
        groupName: "宝牌",
        items:[
            AudioItem(filename: "baopai", displayName: "宝牌"),
            AudioItem(filename: "redbao", displayName: "红宝牌"),
            AudioItem(filename: "insidebao", displayName: "里宝牌")
        ]
    ),
    AudioGroup(
        groupName: "其他",
        items:[
            AudioItem(filename: "menqing", displayName: "门清自摸"),
            AudioItem(filename: "sevencouple", displayName: "七对子"),
            AudioItem(filename: "hunyi", displayName: "混一色"),
            AudioItem(filename: "qingyi", displayName: "清一色"),
            AudioItem(filename: "qianggang", displayName: "抢杠"),
            AudioItem(filename: "flowerinthehill", displayName: "岭上"),
            AudioItem(filename: "moon", displayName: "海底捞月"),
            AudioItem(filename: "fish", displayName: "河底捞鱼")
        ]
    )
]

private let smallAudioGroups = [
    AudioGroup(
        groupName: "立直",
        items: [
            AudioItem(filename: "lizhi", displayName: "立直"),
            AudioItem(filename: "wlizhi", displayName: "双立直")
        ]
    ),
    AudioGroup(
        groupName: "鸣牌",
        items: [
            AudioItem(filename: "chi", displayName: "吃"),
            AudioItem(filename: "pong", displayName: "碰"),
            AudioItem(filename: "kang", displayName: "杠"),
            AudioItem(filename: "bbei", displayName: "拔北")
        ]
    ),
    AudioGroup(
        groupName: "和牌",
        items: [
            AudioItem(filename: "rong", displayName: "荣和"),
            AudioItem(filename: "zimo", displayName: "自摸")
        ]
    )
]

// a enum,but why?
enum Tab: String, CaseIterable
{
    case home = "主页"
    case order = "报菜名"
    case more = "更多"
    case person = "个人"
}

// MARK: Role List
enum Role: String, CaseIterable, Identifiable {
    case yiji = "一姬"
    case youzi = "柚"
    //case low = "省流量"
    
    var id: String { self.rawValue }
}

// MARK: ContentView
struct ContentView: View
{
    @StateObject var audioPlayer = AudioPlayer()
    @AppStorage("crossDeviceSync") var crossDeviceSyncEnabled = false
    
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
                    Label("主页", systemImage: "house")
                }
                .tag(Tab.home)
                
            // order view
            OrderView(audioPlayer: audioPlayer)
                .tabItem
                {
                    Label("报菜名",systemImage: "square.3.stack.3d.top.fill")
                }
                .tag(Tab.order)
            
            // more view
            MoreView()
                .tabItem
                {
                    Label("更多", systemImage: "ellipsis.circle")
                }
                .tag(Tab.more)
                
            // person view
            PersonView()
                .tabItem
                {
                    Label("个人",systemImage:"person.crop.circle")
                }
                .tag(Tab.person)
        }
    }
}

// MARK: AudioButton
struct AudioButton: View
{
    let filename: String
    let displayName: String
    @ObservedObject var audioPlayer: AudioPlayer
    
    var body: some View
    {
        Button(action: { audioPlayer.togglePlayback(for: filename) })
        {
            VStack(spacing: 8)
            {
                ZStack
                {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(audioPlayer.isPlaying(filename: filename) ? Color.blue : Color.blue.opacity(0.7))
                        .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
                        //.frame(width: 60,height: 60)
                    
                    Image(systemName: audioPlayer.isPlaying(filename: filename) ? "pause.fill" : "play.fill")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .aspectRatio(1, contentMode: .fit) // keep square shape
                
                Text(displayName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5) // auto-fit text size
            }
            .padding(10)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 3)
        }
        .buttonStyle(.plain)
    }
}

// MARK: OrderView
struct OrderView: View 
{
    @ObservedObject var audioPlayer: AudioPlayer
    @State private var selectedFiles: Set<String> = []

    // define a grid layout with fixed width
    private var columns: [GridItem] 
    {
        [GridItem(.adaptive(minimum: 60, maximum: 140), spacing: 15)]
    }

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    // define a mapping between category and color
    let categoryColors: [String: Color] = [
        "立直": .red,
        "役牌": .orange,
        "幺九": .yellow,
        "顺子": .green,
        "刻子": .blue,
        "其他": .purple
    ]

    var body: some View 
    {
        NavigationStack 
        {
            ScrollView 
            {
                VStack(spacing: 25) 
                {
                    ForEach(allAudioGroups) 
                    { 
                        group in
                        VStack(alignment: .leading, spacing: 12) 
                        {
                            Text(group.groupName)
                                .font(.headline)
                                .padding(.horizontal)
                                .foregroundColor(.blue)

                            LazyVGrid(columns: columns, spacing: 15) 
                            {
                                ForEach(group.items) 
                                { 
                                    item in
                                    AudioCheckbox(
                                        audioItem: item,
                                        audioPlayer: audioPlayer,
                                        selectedFiles: $selectedFiles,
                                        categoryColor: categoryColors[group.groupName, default: .blue]
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
            .toolbar
            {
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    HStack
                    {
                        // Play Button
                        Button(action:
                        {
                            let sortedFiles = selectedFiles.sorted
                            { first, second in
                                return first < second
                            }
                            audioPlayer.startPlaybackQueue(for: sortedFiles)
                        })
                        {
                            Image(systemName: "play.circle")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.blue)
                        }

                        // Settings Button
                        NavigationLink
                        {
                            OrderSettingsView()
                        }
                        label:
                        {
                            Image(systemName: "gearshape")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }
}

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

// MARK: More
struct MoreView: View
{
    var body: some View 
    {
        NavigationStack 
        {
            Text("更多内容")
                .navigationTitle("更多")
        }
    }
}



// MARK: PersonalView
struct PersonView: View {
    let stats = ["帖子": 238, "关注": 369, "粉丝": 5482]
    //@AppStorage("UserName") public var userNameString = "Username"
    @State private var username = "张小帅"
    @State private var bio = "iOS开发者 | 热爱编程与设计\n分享技术干货与生活日常"
    
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
                    Text("张小帅")
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
                    Text("iOS开发者 | 热爱编程与设计\n分享技术干货与生活日常")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 修改编辑资料按钮
                                   NavigationLink {
                                       EditProfileView(username: $username, bio: $bio)
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
    }
}
// MARK: Home
struct HomeView : View
{
    @ObservedObject var audioPlayer: AudioPlayer
    
    // 定义自适应列布局
    private var columns: [GridItem] 
    {
        [GridItem(.adaptive(minimum: 70, maximum: 160), spacing: 10)]
    }
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View 
    {
        NavigationStack 
        {
            ScrollView 
            {
                VStack(spacing: 25) 
                {
                    ForEach(smallAudioGroups) 
                    { 
                        group in
                        VStack(alignment: .leading, spacing: 12) 
                        {
                            Text(group.groupName)
                                .font(.headline)
                                .padding(.horizontal)
                                .foregroundColor(.blue)
                            
                            LazyVGrid(columns: columns, spacing: 15) 
                            {
                                ForEach(group.items) 
                                { 
                                    item in
                                    AudioButton(
                                        filename: item.filename,
                                        displayName: item.displayName,
                                        audioPlayer: audioPlayer
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
            .toolbar 
            {
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    NavigationLink 
                    {
                        HomeSettingsView()
                    }
                    label: 
                    {
                        Image(systemName: "gearshape")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

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
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .onDisappear
        {
            onDismiss?() // 在页面消失时触发回调以显示 TabView
        }
    }
}

// MARK: OrderSetting
struct OrderSettingsView: View
{
    @Environment(\.dismiss) var dismiss // 使用现代关闭方式
    var onDismiss: (() -> Void)? // 用于在关闭设置页面时触发回调
    @AppStorage("SelectedRole") var selectedRole: Role = .yiji
    
    var body: some View
    {
        Form
        {
            Section("角色设置")
            {
                Picker("角色", selection: $selectedRole)
                {
                    ForEach(Role.allCases)
                    {
                        role in
                        Text(role.rawValue).tag(role)
                    }
                }
                .pickerStyle(.menu) // iOS 默认下拉样式
            }
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
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .onDisappear
        {
            onDismiss?() // 在页面消失时触发回调以显示 TabView
        }
    }
}

// 示例子视图（需要自行实现完整功能）
struct SettingsView: View {
    var body: some View {
        Text("设置页面")
    }
}

struct PrivacyView: View {
    var body: some View {
        Text("隐私设置")
    }
}

struct HelpView: View {
    var body: some View {
        Text("帮助中心")
    }
}

// MARK: - 编辑资料页面
struct EditProfileView: View {
    @Binding var username: String
    @Binding var bio: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("基本信息") {
                    TextField("用户名", text: $username)
                        .autocorrectionDisabled(true)
                    
                    TextField("个人简介", text: $bio, axis: .vertical)
                        .lineLimit(3...5)
                }
                
                Section("账号安全") {
                    //NavigationLink("修改密码") {
                    //    ChangePasswordView()
                    //}
                    
                    //NavigationLink("绑定手机") {
                    //    //PhoneBindingView()
                    //}
                    Text("现在你无需对账号的安全做修改")
                        .padding()
                }
            }
            .navigationTitle("编辑资料")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("完成") {
                        // 这里可以添加保存逻辑
                        dismiss()
                    }
                    .bold()
                }
            }
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
