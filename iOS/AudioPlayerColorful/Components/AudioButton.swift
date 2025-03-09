//
//  AudioButton.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI

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
