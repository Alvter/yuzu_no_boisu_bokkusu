//
//  OrderView.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

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
