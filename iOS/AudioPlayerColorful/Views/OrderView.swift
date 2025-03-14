import SwiftUI
import UIKit



struct OrderView: View {
    @ObservedObject var audioPlayer: AudioPlayer
    @State private var selectedFiles: Set<String> = []
    @State private var baoPaiInputs: [String: String] = [:]
    
    @AppStorage("SelectedRole") var selectedRole: Role = .yiji // 获取选定的角色

    // 加载顺序文件 (从常量字符串)
        func loadAudioOrder() -> AudioOrder? {
            guard let jsonData = audioOrderJSON.data(using: .utf8) else {
                print("JSON 数据转换失败")
                return nil
            }
            let decoder = JSONDecoder()

            do {
                let audioOrder = try decoder.decode(AudioOrder.self, from: jsonData)
                return audioOrder
            } catch {
                print("解析 JSON 数据失败: \(error)")
                return nil
            }
        }
    
    
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 70, maximum: 100), spacing: 10)]
    }

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    let categoryColors: [String: Color] = [
        "立直": .red,
        "役牌": .orange,
        "幺九": .yellow,
        "顺子": .green,
        "刻子": .blue,
        "宝牌": .pink,
        "其他": .purple
    ]

    private var nonBaoPaiGroups: [AudioGroup] {
        allAudioGroups.filter { $0.groupName != "宝牌" }
    }
    
    private var baoPaiGroup: AudioGroup? {
        allAudioGroups.first { $0.groupName == "宝牌" }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    ForEach(nonBaoPaiGroups) { group in
                        VStack(alignment: .leading, spacing: 12) {
                            Text(group.groupName)
                                .font(.headline)
                                .padding(.horizontal)
                                .foregroundColor(.blue)

                            LazyVGrid(columns: columns, spacing: 15) {
                                ForEach(group.items) { item in
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
                    
                    if let baoPaiGroup = baoPaiGroup {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(baoPaiGroup.groupName)
                                .font(.headline)
                                .padding(.horizontal)
                                .foregroundColor(.blue)
                            
                            // 使用更明确的列宽来避免重叠
                            LazyVGrid(columns: [GridItem(.fixed(170), spacing: 10), GridItem(.fixed(170), spacing: 10)], spacing: 15) {
                                ForEach(baoPaiGroup.items) { item in
                                    HStack(spacing: 10) {
                                        AudioCheckbox(
                                            audioItem: item,
                                            audioPlayer: audioPlayer,
                                            selectedFiles: $selectedFiles,
                                            categoryColor: categoryColors[baoPaiGroup.groupName, default: .blue]
                                        )
                                        .frame(width: 80, height: 60)
                                        
                                        TextField("",
                                            text: Binding(
                                                get: { baoPaiInputs[item.filename] ?? "" },
                                                set: { baoPaiInputs[item.filename] = $0 }
                                            )
                                        )
                                        .frame(width: 80, height: 60)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                        .shadow(radius: 3)
                                        .disabled(!selectedFiles.contains(item.filename))
                                        .foregroundColor(selectedFiles.contains(item.filename) ? .black : .gray)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.center)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading) // 确保每一行占满可用宽度
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            guard let audioOrder = loadAudioOrder() else {
                                print("无法加载音频顺序，按照选择顺序播放")
                                let sortedFiles = selectedFiles.sorted()
                                print("播放列表 (默认顺序): \(sortedFiles)") // 打印默认顺序播放列表
                                audioPlayer.startPlaybackQueue(for: sortedFiles, roleName: selectedRole.filenamePrefix)
                                return
                            }

                            // 按照顺序文件中的顺序过滤和排序选中的文件
                            let orderedFiles = audioOrder.order.filter { selectedFiles.contains($0) }

                            // 添加角色名前缀
                            let prefixedFiles = orderedFiles.map { "\(selectedRole.filenamePrefix)_\($0)" }

                            print("播放列表 (带前缀): \(prefixedFiles)") // 打印带前缀的播放列表
                            audioPlayer.startPlaybackQueue(for: prefixedFiles, roleName: selectedRole.filenamePrefix)
                        }) {
                            Image(systemName: "play.circle")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.blue)
                        }


                        NavigationLink {
                            OrderSettingsView()
                        } label: {
                            Image(systemName: "gearshape")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .gesture( // 添加手势
                    TapGesture()
                        .onEnded { _ in
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                          to: nil,
                                                          from: nil,
                                                          for: nil)
                        }
                )
    }
}
